//
//  ChatCell.swift
//  
//
//  Created by kimchansoo on 2023/11/28.
//

import UIKit

import SnapKit
import RxRelay
import RxSwift

import Util
import ChatList

class ChatCell: BaseTableViewCell {
    
    // MARK: - Properties
    lazy var profileImageView: ProfileImageView = {
        let profileImageView = ProfileImageView()
//        profileImageView.backgroundColor = .systemRed
        return profileImageView
    }()
    
    lazy var chatContentView: ChatContentView = {
        let chatContentView = ChatContentView()
        
        return chatContentView
    }()
    
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
//        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // MARK: - Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.disposeBag = DisposeBag()
        self.profileImageView.image = nil
    }
    
    override func configureHierarchy() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(chatContentView)
    }
    
    override func configureConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
            make.width.height.equalTo(28)
        }
        
        configureLayoutAsOther(hasMyChatBefore: false)
    }
    
    override func configureAttributes() {
        super.configureAttributes()
        
    }
    
    func configureCell(by chat: Chat, hasMyChatBefore: Bool, completion: (() -> Void)? = nil) {
        self.profileImageView.setImage(at: URL(string: ""))
        let isMine = chat.createdBy == "me" ? true : false
        self.chatContentView.isMine = isMine
        self.reconfigureLayout(
            by: isMine,
            hasMyChatBefore: hasMyChatBefore
        )
        completion?()
    }
}

// MARK: - Privates
private extension ChatCell {
    
    private func reconfigureLayout(
        by isMine: Bool,
        hasMyChatBefore: Bool
    ) {
        if isMine {
            self.configureLayoutAsMine(hasMyChatBefore: hasMyChatBefore)
        } else {
            self.configureLayoutAsOther(hasMyChatBefore: hasMyChatBefore)
        }
    }
    
    private func configureLayoutAsMine(hasMyChatBefore: Bool) {
        profileImageView.isHidden = true
        let topInset = topInset(when: hasMyChatBefore)
        chatContentView.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.leading.greaterThanOrEqualToSuperview().offset(100)
            make.bottom.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(topInset)
        }
    }
    
    private func configureLayoutAsOther(hasMyChatBefore: Bool) {
        profileImageView.isHidden = false
        let topInset = topInset(when: hasMyChatBefore)
        chatContentView.snp.remakeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualToSuperview().offset(-100)
            make.bottom.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(topInset)
        }
    }
    
    private func topInset(when hasMyChatBefore: Bool) -> CGFloat {
        if hasMyChatBefore {
            return 0
        } else {
            return 8
        }
    }
}
