//
//  Chat.swift
//
//
//  Created by kimchansoo on 2023/11/05.
//

import Foundation

public struct Chat {
    
    let chatID: String
    let message: String
    let isMyMessage: Bool
    
    public init(
        chatID: String,
        message: String,
        isMyMessage: Bool
    ) {
        self.chatID = chatID
        self.message = message
        self.isMyMessage = isMyMessage
    }
}
