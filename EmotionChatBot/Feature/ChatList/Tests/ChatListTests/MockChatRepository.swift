//
//  MockChatRepository.swift
//
//
//  Created by kimchansoo on 2023/11/05.
//

import Foundation

import ChatList

import RxSwift

final class MockChatRepository: ChatRepository {
    
    // MARK: - Properties
    var chatDetailResult: [Chat] = []
    var chatRoomResult: [ChatRoom] = []
    
    // MARK: - Initializers
    
    // MARK: - Methods
    func fetchChatRoomList() -> Observable<[ChatRoom]> {
        return .just(self.chatRoomResult)
    }
    
    func fetchChatDetail(chatId: String) -> Observable<[Chat]> {
        return .just(chatDetailResult)
    }
}

