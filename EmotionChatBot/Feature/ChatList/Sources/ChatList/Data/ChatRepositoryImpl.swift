//
//  ChatRepositoryImpl.swift
//  
//
//  Created by kimchansoo on 2023/11/26.
//

import Foundation

import RxSwift
import Util

public final class ChatRepositoryImpl: ChatRepository {
    
    public init() {
    }
    
    public func fetchChatRoomList() -> Observable<[ChatRoom]> {
        guard let url = URL(string: "https://tiro.tenseconds.site/chats") else {
            return .error(ChatRepositoryError.invalidURL)
        }
        
        return NetworkManager.shared.request(url: url)
        // ChatRoomListDTO -> [ChatRoom]
            .map { (chatRoomListDTO: ChatRoomListDTO) -> [ChatRoom] in
                return chatRoomListDTO.chatrooms
            }
    }
    
    public func createChatRoom() -> Observable<ChatRoom> {
        guard let url = URL(string: "https://tiro.tenseconds.site/chats") else {
            return .error(ChatRepositoryError.invalidURL)
        }
        
        return NetworkManager.shared.request(url: url, method: .post)
    }
    
    public func fetchChatDetail(chatId: Int) -> Observable<[Chat]> {
        guard let url = URL(string: "https://tiro.tenseconds.site/messages") else {
            return .error(ChatRepositoryError.invalidURL)
        }
        
        return NetworkManager.shared.request(url: url, parameters: ["chat_id": chatId])
    }
    
    public func createChatDetail(chatId: Int, message: String) -> Observable<Chat> {
        guard let url = URL(string: "https://tiro.tenseconds.site/messages") else {
            return .error(ChatRepositoryError.invalidURL)
        }
        
        // body에 chat_id와 content 넣어서 보내야 함
        return NetworkManager.shared.request(url: url, method: .post, parameters: ["chat_id": chatId, "content": message])
  
    }
}

enum ChatRepositoryError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case invalidDecoding
}
