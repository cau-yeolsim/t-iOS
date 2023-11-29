//
//  File 2.swift
//  
//
//  Created by kimchansoo on 2023/11/29.
//

import Foundation

struct ChatRequestDTO: Codable {
    let chatId: Int
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case chatId = "chat_id"
        case content
    }
    
    public init(chatId: Int, content: String) {
        self.chatId = chatId
        self.content = content
    }
}
