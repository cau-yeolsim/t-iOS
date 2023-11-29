//
//  ChatContentView.swift
//  
//
//  Created by kimchansoo on 2023/11/28.
//

import UIKit

import Util

final class ChatContentView: BaseView {
    
    // MARK: - Properties
    var isMine: Bool = true {
        didSet { applySenderType() }
    }
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemRed
        applySenderType()
        self.clipsToBounds = true
        self.layer.cornerRadius = 8.0
    }
    
    // MARK: - Methods
    private func applySenderType() {
        self.backgroundColor = isMine ? .lightGray : .gray
    }
}
