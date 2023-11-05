//
//  File.swift
//
//
//  Created by kimchansoo on 2023/11/04.
//

import Foundation

public struct ChatRoom {
    let chatRoomId: String
    let previewImgString: String?
    let previewMessage: String
    let nickname: String
    
    public init(
        chatRoomId: String,
        previewImgString: String?,
        previewMessage: String,
        nickname: String
    ) {
        self.chatRoomId = chatRoomId
        self.previewImgString = previewImgString
        self.previewMessage = previewMessage
        self.nickname = nickname
    }
}
