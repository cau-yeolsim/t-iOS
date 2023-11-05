//
//  ChatListViewModelSpec.swift
//
//
//  Created by kimchansoo on 2023/11/04.
//

import RxSwift
import RxRelay
import Quick
import Nimble

@testable import ChatList

final class ChatListViewModelSpec: QuickSpec {
    override func spec() {
        
        var viewModel: ChatListViewModel!
        
        var viewDidLoad: PublishRelay<Void>!
        var itemSelected: PublishRelay<Int>!
        
        var output : ChatListViewModel.Output!
        
        beforeEach {
            let router = MockChatRouter()
            let repository = MockChatRepository()
            viewModel = ChatListViewModel(
                routing: router,
                chatRepository: repository
            )
            viewDidLoad = PublishRelay<Void>()
            itemSelected = PublishRelay<Int>()
            
            let input = ChatListViewModel.Input(
                viewDidLoad: viewDidLoad.asObservable(),
                itemSelected: itemSelected.asObservable()
            )
            
            output = viewModel.transform(input: input)
        }
        
        describe("진입") {
            
            beforeEach {
                viewDidLoad.accept(())
            }
            
            it("채팅 리스트를 보여준다") {
                expect(output.chatList).toNot(beNil())
            }
            
            context("0번째 채팅이 선택되었을 떄") {
                beforeEach {
                    // 채팅 선택
                    itemSelected.accept(1)
                }
                
                it("채팅방으로 이동한다") {
                    // 채팅방으로 이동
                }
            }
            
            context("존재하지 않는 index의 채팅이 선택됐을 때") {
                
                it("에러를 발생시킨다") {
                    
                }
            }
        }
    }
}

