//
//  File.swift
//
//
//  Created by kimchansoo on 2023/11/04.
//

import Foundation

import RxSwift
import RxCocoa

import Util


public protocol ChatRouting: AnyObject {
    func showChatRoomList()
    func showChatDetail(chatroom: ChatRoom)
    func didFinishChatDetail()
}


public final class ChatListViewModel: ViewModelType {
    
    public struct Input {
        let viewWillAppear: Observable<Void>
        let itemSelected: Observable<Int>
        let createChatRoomButtonTapped: Observable<Void>
    }
    
    public struct Output {
        let chatList: Observable<[ChatRoom]>
    }

    // MARK: - Properties
    
    public var disposeBag = DisposeBag()
    
    private let chatRepository: ChatRepository
    private weak var routing: ChatRouting?
    
    // MARK: - Initializers
    
    public init(
        routing: ChatRouting,
        chatRepository: ChatRepository
    ){
        self.chatRepository = chatRepository
        self.routing = routing
    }
    
    // MARK: - Methods
    
    public func transform(input: Input) -> Output {
//        print(#function)
        let chatListSubject = PublishSubject<[ChatRoom]>()
        
        input.viewWillAppear
            .withUnretained(self)
            .flatMap({ owner, _ in
                owner.chatRepository.fetchChatRoomList()
            })
            .bind(to: chatListSubject)
            .disposed(by: disposeBag)

        input.createChatRoomButtonTapped
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.chatRepository.createChatRoom()
            }
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                owner.chatRepository.fetchChatRoomList()
            }
            .bind(to: chatListSubject)
            .disposed(by: disposeBag)

        input.itemSelected
            .withLatestFrom(chatListSubject) { index, chatList in
                chatList[index]
            }
            .withUnretained(self)
            .subscribe(onNext: { owner, chatroom in
                owner.routing?.showChatDetail(chatroom: chatroom)
            })
            .disposed(by: disposeBag)

        let output = Output(chatList: chatListSubject.asObserver())
        return output
    }

}
