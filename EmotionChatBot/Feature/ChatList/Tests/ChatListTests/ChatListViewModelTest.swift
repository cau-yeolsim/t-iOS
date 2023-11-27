//
//  ChatListViewModelSpec.swift
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

@testable import ChatList

class ChatListViewModelTest: XCTestCase {
    
    var scheduler: TestScheduler!
    var disposebag: DisposeBag!
    
    var viewModel: ChatListViewModel!
    var router: MockChatRouter!
    var repository: MockChatRepository!
    
    var viewWillAppear: PublishSubject<Void>!
    var itemSelected: PublishSubject<Int>!
    
    var output : ChatListViewModel.Output!
    
    // Given
    override func setUp() {
        super.setUp()
        
        scheduler = TestScheduler(initialClock: 0)
        disposebag = DisposeBag()
        
        router = MockChatRouter()
        repository = MockChatRepository()
        viewModel = ChatListViewModel(
            routing: router,
            chatRepository: repository
        )
        viewWillAppear = PublishSubject<Void>()
        itemSelected = PublishSubject<Int>()
        
        let input = ChatListViewModel.Input(
            viewWillAppear: viewWillAppear.asObservable(),
            itemSelected: itemSelected.asObservable()
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
        itemSelected = nil
        
        output = nil
        
        super.tearDown()
    }
    
    func testFetchChatRoomList() throws {
        // Given
        repository.chatRoomResult = self.getMockChatRooms()
        
        // When
        scheduler.createColdObservable([.next(1, ())])
            .bind(to: viewWillAppear)
            .disposed(by: disposebag)
        
        // Then
        expect(self.output.chatList.map{ $0.count })
            .events(scheduler: scheduler, disposeBag: disposebag)
            .to(equal([.next(1, self.getMockChatRooms().count)]))
    }
    
    func testSelectChatRoom() throws {
        // Given
        repository.chatRoomResult = self.getMockChatRooms()
        
        scheduler.createColdObservable([.next(1, ())])
            .bind(to: viewWillAppear)
            .disposed(by: disposebag)
        
        // When
        scheduler.createColdObservable([.next(2, 1)])
            .bind(to: itemSelected)
            .disposed(by: disposebag)
        
        scheduler.start()
        
        // Then
        expect(self.router.didCallShowChatDetail).toEventually(beTrue(), timeout: .seconds(3))
    }
}

extension ChatListViewModelTest {
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
