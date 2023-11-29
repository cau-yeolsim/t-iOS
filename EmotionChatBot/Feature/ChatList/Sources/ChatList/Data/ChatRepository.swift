//
//  ChatRepository.swift
//
//
//  Created by kimchansoo on 2023/11/05.
//

import Foundation

import RxSwift

public protocol ChatRepository {
    
    func fetchChatRoomList() -> Observable<[ChatRoom]>
    func createChatRoom() -> Observable<ChatRoom>
    
    /// 하나의 채팅방의 모든 채팅들 fetch
    func fetchChatList(chatroomId: Int) -> Observable<[Chat]>
    func createChatDetail(chatId: Int, message: String) -> Observable<Chat>
    
    /// 특정 하나의 채팅 fetch
    func fetchChatDetail(chatID: Int) -> Observable<Chat>
}
