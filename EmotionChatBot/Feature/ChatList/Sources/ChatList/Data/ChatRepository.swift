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
    func fetchChatDetail(chatId: Int) -> Observable<[Chat]>
    func createChatDetail(chatId: Int, message: String) -> Observable<Chat>
}
