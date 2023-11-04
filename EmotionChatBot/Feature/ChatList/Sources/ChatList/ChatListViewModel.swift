//
//  File.swift
//
//
//  Created by kimchansoo on 2023/11/04.
//

import Foundation

import RxSwift

import Util

public final class ChatListViewModel: ViewModelType {
    
    public struct Input {
        let viewDidLoad: Observable<Void>
        let itemSelected: Observable<Int>
    }
    
    public struct Output {
        let chatList: Observable<[Chat]>
    }

    // MARK: - Properties
    
    public var disposeBag = DisposeBag()
    
    // MARK: - Initializers
    
    public init() {
        
    }
    
    // MARK: - Methods
    
    
    public func transform(input: Input) -> Output {
        
        
        let chatList = input.viewDidLoad
            .map { [Chat]() }
            .asObservable()
        
        let output = Output(chatList: chatList)
        return output
    }
    
    
    
    
}
