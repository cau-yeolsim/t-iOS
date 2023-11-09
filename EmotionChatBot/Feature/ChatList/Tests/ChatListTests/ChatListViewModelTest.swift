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
    
    // given
    override func setUp() {
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
        scheduler.createColdObservable([.next(1, ())])
            .bind(to: viewWillAppear)
            .disposed(by: disposebag)
        
        // When
        scheduler.createColdObservable([.next(2, 0)])
            .bind(to: itemSelected)
            .disposed(by: disposebag)

        // Then
        expect(self.router.didCallShowChatDetail).toEventually(beTrue(), timeout: .seconds(1))
    }
}

extension ChatListViewModelTest {
    private func getMockChats() -> [Chat] {
        return [
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
            )
        ]
    }
    
    private func getMockChatRooms() -> [ChatRoom] {
        return [
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
        ]
    }
}
