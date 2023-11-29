//
//  Chat.swift
//
//
//  Created by kimchansoo on 2023/11/05.
//

import Foundation

public struct Chat: Codable {
    
    public let chatID: Int
    public let message: String
    public let createdAt: String
    public let createdBy: String
    public let chatroomID: Int
    public let isComplete: Bool
    
    enum CodingKeys: String, CodingKey {
        case chatID = "id"
        case message = "content"
        case createdAt = "created_at"
        case createdBy = "created_by"
        case chatroomID = "chat_id"
        case isComplete = "is_complete"
    }
    
    public init(
        chatID: Int,
        message: String,
        createdAt: String,
        createdBy: String,
        chatroomID: Int,
        isComplete: Bool
    ) {
        self.chatID = chatID
        self.message = message
        self.createdAt = createdAt
        self.createdBy = createdBy
        self.chatroomID = chatroomID
        self.isComplete = isComplete
    }
}

extension Chat: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(chatID)
    }
    
    public static func == (lhs: Chat, rhs: Chat) -> Bool {
        return lhs.chatID == rhs.chatID
    }
}
