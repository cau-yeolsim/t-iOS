//
//  File.swift
//  
//
//  Created by kimchansoo on 2023/11/28.
//

import UIKit

import SnapKit

import ChatList
import Util

final class TextChatCell: ChatCell {
    
    // MARK: - Properties
    private lazy var chatLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initializers
    
    // MARK: - Methods
    override func configureHierarchy() {
        super.configureHierarchy()
        
        self.chatContentView.addSubview(chatLabel)
    }
    
    override func configureConstraints() {
        super.configureConstraints()
        
        chatLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview().inset(8)
            make.height.greaterThanOrEqualTo(10)
        }
        
        
        
    }
    
    override func configureCell(by chat: Chat, hasMyChatBefore: Bool, completion: (() -> Void)? = nil) {
        super.configureCell(by: chat, hasMyChatBefore: hasMyChatBefore, completion: completion)
        
        self.chatLabel.text = chat.message
    }
}
