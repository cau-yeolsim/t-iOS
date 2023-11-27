//
//  ChatRoomListDTO.swift
//  
//
//  Created by kimchansoo on 2023/11/27.
//

import Foundation

public struct ChatRoomListDTO: Codable {
    let chatrooms: [ChatRoom]
    
    enum CodingKeys: String, CodingKey {
        case chatrooms = "chats"
    }
    
    public init(chatrooms: [ChatRoom]) {
        self.chatrooms = chatrooms
    }
}
