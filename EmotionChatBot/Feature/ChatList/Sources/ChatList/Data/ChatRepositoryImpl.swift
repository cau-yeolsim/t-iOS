//
//  ChatRepositoryImpl.swift
//  
//
//  Created by kimchansoo on 2023/11/26.
//

import Foundation

import Alamofire
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
    
    public func fetchChatList(chatroomId: Int) -> Observable<[Chat]> {
        guard let url = URL(string: "https://tiro.tenseconds.site/messages") else {
            return .error(ChatRepositoryError.invalidURL)
        }
        
        return NetworkManager.shared.request(url: url, parameters: ["chat_id": chatroomId])
            .map { (chatListDTO: ChatListDTO) -> [Chat] in
                return chatListDTO.messages
            }
    }
    
    public func createChatDetail(chatId: Int, message: String) -> Observable<Chat> {
        guard let url = URL(string: "https://tiro.tenseconds.site/messages") else {
            return .error(ChatRepositoryError.invalidURL)
        }
        let headers: HTTPHeaders = [
              "Content-Type": "application/json",
              "Accept": "application/json"
          ]
        
        return NetworkManager.shared.request(
            url: url,
            method: .post,
            parameters: ["chat_id": chatId, "content": message],
            encoding: JSONEncoding.default,
            headers: headers
        )
    }
    
    public func fetchChatDetail(chatID: Int) -> Observable<Chat> {
        guard let url = URL(string: "https://tiro.tenseconds.site/messages/\(chatID)") else {
            return .error(ChatRepositoryError.invalidURL)
        }
        
        return NetworkManager.shared.request(url: url)
    }
}

enum ChatRepositoryError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case invalidDecoding
}
