//
//  Chat.swift
//
//
//  Created by kimchansoo on 2023/11/05.
//

import Foundation

public struct Chat: Codable {
    
    let chatID: Int
    let message: String
    let createdAt: String
    let createdBy: String
    let chatroomID: Int
    
    enum CodingKeys: String, CodingKey {
        case chatID = "id"
        case message = "content"
        case createdAt = "created_at"
        case createdBy = "created_by"
        case chatroomID = "chat_id"
    }
    
    public init(
        chatID: Int,
        message: String,
        createdAt: String,
        createdBy: String,
        chatroomID: Int
    ) {
        self.chatID = chatID
        self.message = message
        self.createdAt = createdAt
        self.createdBy = createdBy
        self.chatroomID = chatroomID
    }
}
