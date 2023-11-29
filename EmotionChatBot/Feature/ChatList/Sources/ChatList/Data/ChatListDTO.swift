//
//  File.swift
//  
//
//  Created by kimchansoo on 2023/11/28.
//

import Foundation

public struct ChatListDTO: Codable {
    let messages: [Chat]
    
    public init(messages: [Chat]) {
        self.messages = messages
    }
}
