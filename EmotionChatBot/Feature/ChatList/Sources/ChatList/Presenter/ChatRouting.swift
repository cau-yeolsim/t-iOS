//
//  ChatCoordinator.swift
//
//
//  Created by kimchansoo on 2023/11/05.
//

import UIKit

import Util

import RxSwift

public protocol ChatRouting: AnyObject {
    func showChatRoomList()
    func showChatDetail(chatID: Int)
    func didFinishChatDetail()
}


public final class ChatCoordinator: ChatRouting, Coordinator {
    public var delegate: CoordinatorDelegate?
    
    public var childCoordinators: [Coordinator]
    
    public var navigationController: UINavigationController
    
    public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    
    public func start() {
        
    }
    
    public func showChatRoomList() {
        // TODO: - mock 지우고 나중에 구현체 넣기
        let chatRepository = ChatRepositoryImpl()
        
        let vm = ChatListViewModel(
            routing: self,
            chatRepository: chatRepository
        )
        let viewController = ChatListViewController(viewModel: vm)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    public func showChatDetail(chatID: Int) {
    }
    
    public func didFinishChatDetail() {
        popViewController()
    }
}


final class TempMockChatRepository: ChatRepository {
    
    // MARK: - Properties
    var chatDetailResult: [Chat] = []
    var chatRoomResult: [ChatRoom] = [
        ChatRoom(
            chatRoomId: 1,
            previewImgString: "",
            title: "채팅방1",
            createdAt: "2021-10-30 00:00:00",
            lastMessage: nil
        ),
        ChatRoom(
            chatRoomId: 2,
            previewImgString: "",
            title: "채팅방2",
            createdAt: "2021-10-30 00:00:00",
            lastMessage: nil
        ),
        ChatRoom(
            chatRoomId: 3,
            previewImgString: "",
            title: "채팅방3",
            createdAt: "2021-10-30 00:00:00",
            lastMessage: nil
        ),
        ChatRoom(
            chatRoomId: 4,
            previewImgString: "",
            title: "채팅방4",
            createdAt: "2021-10-30 00:00:00",
            lastMessage: nil
        ),
    ]
    
    // MARK: - Initializers
    
    // MARK: - Methods
    func fetchChatRoomList() -> Observable<[ChatRoom]> {
        return Observable.just(self.chatRoomResult)

    }
    
    func fetchChatDetail(chatId: Int) -> Observable<[Chat]> {
        return Observable.create { oberver in
            oberver.onNext(self.chatDetailResult)
            return Disposables.create()
        }
    }
    
    func createChatRoom() -> RxSwift.Observable<ChatRoom> {
        return Observable.just(
            ChatRoom(
                chatRoomId: 1,
                previewImgString: "",
                title: "채팅방1",
                createdAt: "2021-10-30 00:00:00",
                lastMessage: nil
            )
        )
    }
   
    
    func createChatDetail(chatId: Int, message: String) -> RxSwift.Observable<Chat> {
        return Observable.just(
            Chat(
                chatID: 1,
                message: "hi",
                createdAt: "2021-10-30 00:00:00",
                createdBy: "2021-10-30 00:00:00",
                chatroomID: 1
            )
        )
    }

}

