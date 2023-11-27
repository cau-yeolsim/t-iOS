//
//  ChatPreviewCell.swift
//
//
//  Created by kimchansoo on 2023/11/09.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

import Util

final class ChatPreviewCell: BaseTableViewCell {
    
    // MARK: - UI
    private lazy var profileImageView: ProfileImageView = {
        let profileImageView = ProfileImageView()
        
        return profileImageView
    }()
    
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private lazy var chatPreviewLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
        
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - Methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.profileImageView.image = nil
        self.nicknameLabel.text = ""
        self.chatPreviewLabel.text = ""
    }
    
    override func configureHierarchy() {
        [
            profileImageView,
            nicknameLabel,
            chatPreviewLabel,
        ].forEach { self.contentView.addSubview($0) }
    }
    
    override func configureConstraints() {
        let padding = 16
        
        profileImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(padding)
            make.width.equalTo(self.profileImageView.snp.height)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.profileImageView.snp.trailing).offset(padding)
            make.top.equalToSuperview().offset(padding + 2)
        }
        
        chatPreviewLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.nicknameLabel.snp.leading)
            make.bottom.equalToSuperview().offset(-(padding + 2))
        }
    }
}

// MARK: - Privates
extension ChatPreviewCell {
    
    func configureCell(_ chatRoom: ChatRoom) {
        self.profileImageView.setImage(at: URL(string: chatRoom.previewImgString ?? ""))
        self.nicknameLabel.text = chatRoom.title
        self.chatPreviewLabel.text = chatRoom.lastMessage?.message ?? ""
    }
}

