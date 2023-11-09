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

public final class ChatListViewModel: ViewModelType {
    
    public struct Input {
        let viewWillAppear: Observable<Void>
        let itemSelected: Observable<Int>
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
        print(#function)
        let chatList = input.viewWillAppear
            .withUnretained(self)
            .flatMap({ owner, _ in
                owner.chatRepository.fetchChatRoomList()
            })
            .share()

        input.itemSelected
            .withLatestFrom(chatList) { index, chatList in
                chatList[index]
            }
            .withUnretained(self)
            .subscribe(onNext: { owner, chat in
                owner.routing?.showChatDetail(chatID: chat.chatRoomId)
            })
            .disposed(by: disposeBag)

        let output = Output(chatList: chatList)
        return output
    }
}
