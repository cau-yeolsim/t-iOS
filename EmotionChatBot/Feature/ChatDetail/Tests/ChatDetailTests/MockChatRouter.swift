//
//  MockChatRouter.swift
//
//
//  Created by kimchansoo on 2023/11/05.
//

import Foundation

import ChatList

public final class MockChatRouter: ChatRouting {
    
    public var didCallShowChatDetail = false
    public var didCallShowChatRoomList = false
    public var didChatDetailFinished = false
    
    public func showChatRoomList() {
        self.didCallShowChatRoomList = true
    }
    
    public func showChatDetail(chatroom: ChatRoom) {
        self.didCallShowChatDetail = true
    }
    
    public func didFinishChatDetail() {
        self.didChatDetailFinished = true
    }
}
