//
//  BaseView.swift
//  
//
//  Created by kimchansoo on 2023/11/28.
//

import UIKit
import RxSwift

open class BaseView: UIView {
    
    // MARK: - Properties
    public var disposeBag = DisposeBag()
    
    // MARK: - Methods
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        configureAttributes()
        configureHierarchy()
        configureConstraints()
        bind()
    }
    
    open func configureHierarchy() {}
    open func configureConstraints() {}
    open func configureAttributes() {}
    open func bind() {}
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) is called.")
    }
}
