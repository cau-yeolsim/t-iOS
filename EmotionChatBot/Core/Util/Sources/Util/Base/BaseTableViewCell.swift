//
//  BaseTableViewCell.swift
//  
//
//  Created by kimchansoo on 2023/11/09.
//

import UIKit

import RxSwift
import RxCocoa

@objc protocol BaseTableViewCellDelegate {
    @objc optional func didTapButton()
}

open class BaseTableViewCell: UITableViewCell {
    
    weak var delegate: BaseTableViewCellDelegate?
    // MARK: - Properties
    var disposeBag = DisposeBag()
    
    // MARK: - Methods
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) is called.")
    }
}

final class RxBaseTableViewCellProxy: DelegateProxy<BaseTableViewCell, BaseTableViewCellDelegate>, DelegateProxyType, BaseTableViewCellDelegate {
    
    static func registerKnownImplementations() {
        self.register { tableViewCell -> RxBaseTableViewCellProxy in
            RxBaseTableViewCellProxy(parentObject: tableViewCell, delegateProxy: self)
        }
    }

    static func currentDelegate(for object: BaseTableViewCell) -> BaseTableViewCellDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: BaseTableViewCellDelegate?, to object: BaseTableViewCell) {
        object.delegate = delegate
    }
}

extension Reactive where Base: BaseTableViewCell {
    var rxdelegate: DelegateProxy<BaseTableViewCell, BaseTableViewCellDelegate> {
        return RxBaseTableViewCellProxy.proxy(for: self.base)
    }
    
    var rxShowViewController: Observable<Void> {
        return rxdelegate.sentMessage(#selector(BaseTableViewCellDelegate.didTapButton)).map { _ in }
    }
}

