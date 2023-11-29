//
//  ChatTableView.swift
//  
//
//  Created by kimchansoo on 2023/11/28.
//

import UIKit

final class ChatTableView: UITableView {
    
    // MARK: - Properties
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero, style: .plain)
        
        self.separatorStyle = .none
        self.allowsSelection = false
        self.register()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func register() {
        self.register(ChatCell.self)
        self.register(TextChatCell.self)
    }
}
