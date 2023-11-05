//
//  ViewModelType.swift
//
//
//  Created by kimchansoo on 2023/11/04.
//

import RxSwift

import Combine

@MainActor
public protocol ViewModelType: AnyObject {
    
    associatedtype Input
    associatedtype Output
    
    // MARK: - Properties
    var disposeBag: DisposeBag { get }
//    var cancellable: Set<AnyCancellable> { get }
    
    // MARK: - Methods
    func transform(input: Input) -> Output
}
