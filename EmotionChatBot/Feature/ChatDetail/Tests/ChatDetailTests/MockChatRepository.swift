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
    
    func fetchChatDetail(chatId: Int) -> Observable<[Chat]> {
        return .just(chatDetailResult)
    }
    
    func createChatRoom() -> Observable<ChatList.ChatRoom> {
        return .just(chatRoomResult.first!)
    }
    
    func createChatDetail(chatId: Int, message: String) -> RxSwift.Observable<ChatList.Chat> {
        return .just(chatDetailResult.first!)
    }

}

