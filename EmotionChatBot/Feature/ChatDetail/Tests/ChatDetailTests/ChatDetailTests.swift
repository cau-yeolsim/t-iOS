//
//  ChatDetailViewModelSpec.swift
//
//
//  Created by kimchansoo on 2023/11/04.
//


import RxSwift
import RxCocoa

import Nimble
import RxNimble

import XCTest
import RxTest

import ChatList

@testable import ChatDetail

final class ChatDetailViewModelTests: XCTestCase {
    
    var scheduler: TestScheduler!
    var disposebag: DisposeBag!
    
    var viewModel: ChatDetailViewModel!
    var router: MockChatRouter!
    var repository: MockChatRepository!
    
    var viewWillAppear: PublishSubject<Void>!
    var sendChatText: PublishSubject<String>!
    var backButtonTapped: PublishSubject<Void>!
    
    var output : ChatDetailViewModel.Output!

    // Given
    override func setUp() {
        super.setUp()
        
        scheduler = TestScheduler(initialClock: 0)
        disposebag = DisposeBag()
        
        router = MockChatRouter()
        repository = MockChatRepository()
        viewModel = ChatDetailViewModel(
            routing: router,
            chatRepository: repository
        )

        viewWillAppear = PublishSubject<Void>()

        
        let input = ChatDetailViewModel.Input(
            viewWillAppear: viewWillAppear.asObservable(),
            sendChatText: sendChatText.asObservable(),
            backButtonTapped: backButtonTapped.asObservable()
        )
        
        output = viewModel.transform(input: input)
    }

    override func tearDown() {
        scheduler = nil
        disposebag = nil
        
        viewModel = nil
        router = nil
        repository = nil
        
        viewWillAppear = nil
        sendChatText = nil
        backButtonTapped = nil
        
        output = nil
        
        super.tearDown()
    }
    
    func test_채팅_리스트_불러오기() {
        // Given
        repository.chatDetailResult = self.getMockChats()
        
        // When
        scheduler.createColdObservable([.next(1, ())])
            .bind(to: viewWillAppear)
            .disposed(by: disposebag)
        
        // Then
        expect(self.output.chatList.map(\.count))
            .events(scheduler: scheduler, disposeBag: disposebag)
            .to(equal([.next(1, self.getMockChats().count)]))
    }
    
    func test_채팅_보내기() {
        // Given
        repository.chatDetailResult = self.getMockChats()
        
        // When
        scheduler.createColdObservable([.next(1, "안녕")])
            .bind(to: sendChatText)
            .disposed(by: disposebag)
        
        // Then
        expect(self.output.chatList.map(\.count))
            .events(scheduler: scheduler, disposeBag: disposebag)
            .to(equal([.next(1, self.getMockChats().count)]))
    }
    
    func test_뒤로가기() {
        // Given
        repository.chatDetailResult = self.getMockChats()
        
        // When
        scheduler.createColdObservable([.next(1, ())])
            .bind(to: backButtonTapped)
            .disposed(by: disposebag)
        
        scheduler.start()
        
        // Then
        expect(self.router.didChatDetailFinished)
            .toEventually(beTrue(), timeout: .seconds(3))
    }
}

extension ChatDetailViewModelTests {
    private func getMockChats() -> [Chat] {
        return [
            Chat(
                chatID: 1,
                message: "안녕",
                createdAt: "2021-10-10",
                createdBy: "김찬수",
                chatroomID: 1
            ),
            Chat(
                chatID: 2,
                message: "안녕하세요",
                createdAt: "2021-10-10",
                createdBy: "김찬수",
                chatroomID: 1
            ),
            Chat(
                chatID: 3,
                message: "안녕하세요?",
                createdAt: "2021-10-10",
                createdBy: "김찬수",
                chatroomID: 1
            ),
        ]
    }
    
    private func getMockChatRooms() -> [ChatRoom] {
        return [
            ChatRoom(
                chatRoomId: 1,
                previewImgString: "",
                title: "티로 1",
                createdAt: "2021-10-10",
                lastMessage:
                    Chat(
                        chatID: 3,
                        message: "안녕하세요?",
                        createdAt: "2021-10-10",
                        createdBy: "김찬수",
                        chatroomID: 1
                    )
            ),
            ChatRoom(
                chatRoomId: 2,
                previewImgString: "",
                title: "티로 2",
                createdAt: "2021-10-10",
                lastMessage: nil
            ),
            ChatRoom(
                chatRoomId: 3,
                previewImgString: "",
                title: "티로 3",
                createdAt: "2021-10-10",
                lastMessage: nil
            ),
        ]
    }
}
