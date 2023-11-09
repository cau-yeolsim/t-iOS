//
//  ViewModelType.swift
//
//
//  Created by kimchansoo on 2023/11/04.
//

import RxSwift

public protocol ViewModelType: AnyObject {
    
    associatedtype Input
    associatedtype Output
    
    // MARK: - Properties
    var disposeBag: DisposeBag { get }
    
    // MARK: - Methods
    func transform(input: Input) -> Output
}
