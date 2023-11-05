//
//  BaseViewController.swift
//  
//
//  Created by kimchansoo on 2023/11/05.
//

import UIKit

import RxSwift
import SnapKit

public class BaseViewController: UIViewController {
    
    // MARK: - Properties
    var disposeBag = DisposeBag()
    
    private var indicator: UIActivityIndicatorView?
    
    // MARK: - Methods
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        configureAttributes()
        configureHierarchy()
        configureConstraints()
        bind()
    }
    
    func configureHierarchy() {}
    func configureConstraints() {}
    func configureAttributes() {}
    func bind() {}
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) is called.")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
}

// MARK: - Indicator
public extension BaseViewController {
    
    func showFullSizeIndicator() {
        let indicator = createIndicator()
        self.indicator = indicator
        
        self.view.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.center.equalToSuperview()
        }
        
        indicator.startAnimating()
    }
    
    func hideFullSizeIndicator() {
        self.indicator?.stopAnimating()
        self.indicator?.removeFromSuperview()
        self.indicator = nil
    }
    
    private func createIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        
        indicator.backgroundColor = .black.withAlphaComponent(0.7)
        indicator.color = .white
        indicator.layer.cornerRadius = 20
        return indicator
    }
}
