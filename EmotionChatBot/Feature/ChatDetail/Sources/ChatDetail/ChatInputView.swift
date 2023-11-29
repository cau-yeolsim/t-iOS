//
//  ChatInputView.swift
//  
//
//  Created by kimchansoo on 2023/11/28.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

import Util

final class ChatInputView: BaseView {
    
    // MARK: - Properties
    private lazy var chatTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = .systemFont(ofSize: 14)
        return textField
    }()
    
    private lazy var sendChatButton: UIButton = {
        let button = UIButton()
        //버튼 이미지 색상 변경
        button.tintColor = .black
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        return button
    }()
    
    private lazy var chatInputContainerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.addBorder()
        return view
    }()
    
    // MARK: - Initializers
    
    // MARK: - Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let sendChatCornerRadius = self.sendChatButton.frame.height / 2
        let inputContainerViewCornerRadius = self.chatInputContainerView.frame.height / 2
        
        self.sendChatButton.layer.cornerRadius = sendChatCornerRadius
        self.chatInputContainerView.layer.cornerRadius = inputContainerViewCornerRadius
        self.layer.addBorder([.top])
    }
    
    override func configureHierarchy() {
        self.addSubview(self.chatInputContainerView)
        
        [chatTextField, sendChatButton]
            .forEach { self.chatInputContainerView.addSubview($0) }
    }
    
    override func configureConstraints() {
        chatInputContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        chatTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(sendChatButton.snp.leading).offset(-16)
        }
        
        sendChatButton.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalTo(self.sendChatButton.snp.height)
        }
        
    }
    
    override func bind() {
        self.followKeyboardObserver()
            .disposed(by: disposeBag)
        
        self.chatTextField.rx.text
            .orEmpty
            .map(\.isEmpty)
            .map { !$0 }
            .bind(to: sendChatButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

// MARK: - Rx Observers
extension ChatInputView {
    
    var didTapSend: Signal<Void> {
        return sendChatButton.rx.tap.asSignal()
    }
    
    var textObservable: Observable<String> {
        return chatTextField.rx.text.orEmpty.asObservable()
    }
    
    var didTapSendWithText: Signal<String> {
        return sendChatButton.rx.tap
            .withUnretained(self) { owner, _ in
                let text = owner.chatTextField.text ?? ""
                
                owner.chatTextField.text = ""
                owner.sendChatButton.isEnabled = false
                return text
            }
            .asSignal(onErrorJustReturn: "")
    }
}
