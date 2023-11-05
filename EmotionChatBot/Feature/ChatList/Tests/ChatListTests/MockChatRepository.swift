//
//  MockChatRepository.swift
//
//
//  Created by kimchansoo on 2023/11/05.
//

import Foundation

import ChatList

import RxSwift

final class MockChatRepository: ChatRepository {
    
    // MARK: - Properties
    
    // MARK: - Initializers
    
    // MARK: - Methods
    func fetchChatRoomList() -> Observable<[ChatRoom]> {
        return Observable.create { observer in
            observer.onNext([
                ChatRoom(
                    chatRoomId: "1",
                    previewImgString: "",
                    previewMessage: "안녕하세요?",
                    nickname: "김찬수"
                ),
                ChatRoom(
                    chatRoomId: "2",
                    previewImgString: "",
                    previewMessage: "안녕하세요?222",
                    nickname: "문상헌"
                ),
                ChatRoom(
                    chatRoomId: "3",
                    previewImgString: "",
                    previewMessage: "안녕하세요??333",
                    nickname: "양석환"
                ),
            ])
            return Disposables.create()
        }
    }
    
    func fetchChatDetail(chatId: String) -> Observable<[Chat]> {
        return Observable.create { oberver in
            oberver.onNext([
                Chat(
                    chatID: "1",
                    message: "hi",
                    isMyMessage: true
                ),
                Chat(
                    chatID: "2",
                    message: "hihi",
                    isMyMessage: false
                ),
                Chat(
                    chatID: "3",
                    message: "hihihi",
                    isMyMessage: true
                ),
            ])
            return Disposables.create()
        }
    }
}
