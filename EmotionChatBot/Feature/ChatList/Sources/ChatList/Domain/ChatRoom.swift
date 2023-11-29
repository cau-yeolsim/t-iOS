//
//  File.swift
//
//
//  Created by kimchansoo on 2023/11/04.
//

import Foundation

public struct ChatRoom: Codable {
    public let chatRoomId: Int
    public let previewImgString: String?
    public let title: String
    public let createdAt: String
    public let lastMessage: Chat?
    
    enum CodingKeys: String, CodingKey {
        case chatRoomId = "id"
        case previewImgString = "profile_img_url"
        case title
        case createdAt = "created_at"
        case lastMessage = "last_message"
    }
    
    public init(
        chatRoomId: Int,
        previewImgString: String?,
        title: String,
        createdAt: String,
        lastMessage: Chat?
    ) {
        self.chatRoomId = chatRoomId
        self.previewImgString = previewImgString
        self.title = title
        self.createdAt = createdAt
        self.lastMessage = lastMessage
    }
}

extension ChatRoom: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(chatRoomId)
    }
    
    public static func == (lhs: ChatRoom, rhs: ChatRoom) -> Bool {
        return lhs.chatRoomId == rhs.chatRoomId
    }
}
