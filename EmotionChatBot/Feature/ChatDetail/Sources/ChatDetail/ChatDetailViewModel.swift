//
//  ChatDetailViewModel.swift
//  
//
//  Created by kimchansoo on 2023/11/28.
//

import Foundation

import RxSwift
import RxCocoa

import Util
import ChatList

public final class ChatDetailViewModel: ViewModelType {
    
    public struct Input {
        let viewWillAppear: Observable<Void>
        let sendChatText: Observable<String>
        let backButtonTapped: Observable<Void>
    }
    
    public struct Output {
        let currentChatRoom: Observable<ChatRoom>
        let chatList: Observable<[Chat]>
        let lastChat: Observable<Chat>
        let isLoading: Observable<Bool>
    }
    
    // MARK: - Properties
    
    public var disposeBag = DisposeBag()
    
    private let chatRepository: ChatRepository
    private weak var routing: ChatRouting?
    
    private let chatroom: ChatRoom
    
    // MARK: - Initializers
    
    public init(
        routing: ChatRouting,
        chatRepository: ChatRepository,
        chatroom: ChatRoom
    ){
        self.chatRepository = chatRepository
        self.routing = routing
        self.chatroom = chatroom
    }
    
    // MARK: - Override
    
    public func transform(input: Input) -> Output {
        let chatListSubject = PublishSubject<[Chat]>()
        
        input.viewWillAppear
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.chatRepository.fetchChatList(chatroomId: owner.chatroom.chatRoomId)
            }
            .bind(to: chatListSubject)
            .disposed(by: disposeBag)
        
        let lastChatSubject = PublishSubject<Chat>()
        
        input.sendChatText
            .withUnretained(self)
            .flatMap { owner, text in
                owner.chatRepository.createChatDetail(chatId: owner.chatroom.chatRoomId, message: text)
            }
            .bind(to: lastChatSubject)
            .disposed(by: disposeBag)
        
        lastChatSubject
            .filter { !$0.isComplete }
            .withUnretained(self)
            .flatMap { owner, _ -> Observable<[Chat]> in
                owner.chatRepository.fetchChatList(chatroomId: owner.chatroom.chatRoomId)
            }
            .bind(to: chatListSubject)
            .disposed(by: disposeBag)
        
        lastChatSubject
            .filter { !$0.isComplete }
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .withUnretained(self)
            .flatMap { owner, chat in
                owner.chatRepository.fetchChatDetail(chatID: chat.chatID)
            }
            .bind(to: lastChatSubject)
            .disposed(by: disposeBag)
//        lastChatSubject
//            .filter { !$0.isComplete }
//            .withUnretained(self)
//            .flatMap { owner, _ -> Observable<[Chat]> in
//                owner.chatRepository.fetchChatList(chatroomId: owner.chatroom.chatRoomId)
//            }
//            .withUnretained(self)
//            .flatMap { owner, chatList -> Observable<Chat> in
//                guard let lastChat = chatList.last else {
//                    return Observable.just(Chat()) // 또는 적절한 기본값 반환
//                }
//                return owner.chatRepository.fetchChatDetail(chatID: lastChat.chatID)
//                    .delay(.seconds(1), scheduler: MainScheduler.instance)
//            }
//            .bind(to: lastChatSubject)
//            .disposed(by: disposeBag)

        
        return Output(
            currentChatRoom: .just(self.chatroom),
            chatList: chatListSubject.map { $0.reversed() }.asObservable().share(),
            lastChat: lastChatSubject.asObservable(),
            isLoading: Observable.never()
        )
    }
    
    // MARK: - Methods
}
