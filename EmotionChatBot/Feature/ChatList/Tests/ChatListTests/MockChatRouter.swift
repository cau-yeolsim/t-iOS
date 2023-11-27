//
//  MockChatRouter.swift
//
//
//  Created by kimchansoo on 2023/11/05.
//

import Foundation

import ChatList

final class MockChatRouter: ChatRouting {
    
    var didCallShowChatDetail = false
    var didCallShowChatRoomList = false
    var didChatDetailFinished = false
    
    func showChatRoomList() {
        self.didCallShowChatRoomList = true
    }
    
    func showChatDetail(chatID: Int) {
        self.didCallShowChatDetail = true
    }
    
    func didFinishChatDetail() {
        self.didChatDetailFinished = true
    }
}
