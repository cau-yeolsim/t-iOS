//
//  ChatDetailViewModel.swift
//  
//
//  Created by kimchansoo on 2023/11/28.
//

import Foundation

import RxSwift
import RxCocoa

import Util
import ChatList

public final class ChatDetailViewModel: ViewModelType {
    
    public struct Input {
        let viewWillAppear: Observable<Void>
        let sendChatText: Observable<String>
        let backButtonTapped: Observable<Void>
    }
    
    public struct Output {
        let chatList: Observable<[Chat]>
        let lastChat: Observable<Chat>
        let isLoading: Observable<Bool>
    }
    
    // MARK: - Properties
    public var disposeBag = DisposeBag()
    
    private let chatRepository: ChatRepository
    private weak var routing: ChatRouting?
    
    // MARK: - Initializers
    public init(
        routing: ChatRouting,
        chatRepository: ChatRepository
    ){
        self.chatRepository = chatRepository
        self.routing = routing
    }
    
    // MARK: - Override
    
    public func transform(input: Input) -> Output {
        
    }
    
    // MARK: - Methods
}
