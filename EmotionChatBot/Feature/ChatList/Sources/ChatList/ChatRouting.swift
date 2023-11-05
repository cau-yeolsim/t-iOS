//
//  ChatCoordinator.swift
//
//
//  Created by kimchansoo on 2023/11/05.
//

import UIKit

import Util

@MainActor
public protocol ChatRouting: AnyObject {
    func showChatRoomList(userID: String)
    func showChatDetail(chatID: String)
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
    
    public func showChatRoomList(userID: String) {
        let viewController = ChatListViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    public func showChatDetail(chatID: String) {
    }
    
    public func didFinishChatDetail() {
        popViewController()
    }
}
