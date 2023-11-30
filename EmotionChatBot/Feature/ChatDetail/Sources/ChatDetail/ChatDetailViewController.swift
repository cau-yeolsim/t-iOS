//
//  ChatDetailViewController.swift
//  
//
//  Created by kimchansoo on 2023/11/28.
//

import UIKit

import RxSwift
import SnapKit

import Util
import ChatList

public final class ChatDetailViewController: BaseViewController {
    
    // MARK: - UI
    
    private lazy var chatInputView: ChatInputView = {
        let inputView = ChatInputView()
        
        return inputView
    }()
    
    private lazy var chatTableView: ChatTableView = {
        let chatTableView = ChatTableView()
        
        chatTableView.keyboardDismissMode = .onDrag
        return chatTableView
    }()
    
    // MARK: - Properties
    
    private let viewModel: ChatDetailViewModel
    private var dataSource: UITableViewDiffableDataSource<Section, Chat>?
    
    // MARK: - Initializers
  
    public init(viewModel: ChatDetailViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    // MARK: - Override
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureNavigationController()
    }
    
    public override func configureHierarchy() {
        self.view.addSubview(chatInputView)
        self.view.addSubview(chatTableView)
    }
    
    public override func configureConstraints() {
        chatInputView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(56)
        }
        
        chatTableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.chatInputView.snp.top)
        }
    }
    
    
    public override func configureAttributes() {
        self.view.backgroundColor = .white
        
        self.dataSource = self.configureDataSource()
        
        configureNavigationController()
        
    }
    
    public override func bind() {
        let input = ChatDetailViewModel.Input(
            viewWillAppear: self.rx.viewWillAppear.asObservable(),
            sendChatText: chatInputView.didTapSendWithText.asObservable(),
            backButtonTapped: .never()
        )
        
        let output = viewModel.transform(input: input)
        
        output.currentChatRoom
            .subscribe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, chatroom in
                owner.title = chatroom.title
            })
            .disposed(by: disposeBag)
        
        output.chatList
            .subscribe(on: MainScheduler.instance)
            .map { self.generateSnapshot($0) }
            .subscribe(onNext: { [weak self] snapshot in
                self?.dataSource?.apply(snapshot, animatingDifferences: false) {
                    self?.scrollToBottom()
//                    self?.chatTableView.setNeedsLayout()
                }
            })
            .disposed(by: disposeBag)
        
        
    }
    
    // MARK: - Methods

    private func scrollToBottom() {
        // tableView의 가장 큰 ChatIndex를 받아온다.
        let lastChatIndex = self.chatTableView.numberOfRows(inSection: 0) - 1
        if lastChatIndex == -1 { return }
        let lastIndexPath = IndexPath(row: lastChatIndex, section: 0)
        self.chatTableView.reloadData()
        self.chatTableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
}

extension ChatDetailViewController {
    
    func configureNavigationController() {
        // navigationBar가 full로 뜨지 않게
        self.navigationController?.navigationBar.prefersLargeTitles = false
        let appearance = UINavigationBarAppearance()
        let backButtonImage = UIImage(systemName: "arrow.left")?
            .withTintColor(.black, renderingMode: .alwaysOriginal)
        
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .white
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }

}


// MARK: - Diffable DataSource
extension ChatDetailViewController {
    
    enum Section: CaseIterable {
        case main
    }
    
    func generateSnapshot(_ sources: [Chat]) -> NSDiffableDataSourceSnapshot<Section, Chat> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Chat>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(sources)
        return snapshot
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Chat> {
        return UITableViewDiffableDataSource(
            tableView: self.chatTableView
        ) { [weak self] tableView, indexPath, item in
            guard
                let self = self,
                let cell = tableView.dequeueCell(TextChatCell.self, for: indexPath)
            else {
                return UITableViewCell()
            }
            
            let hasMyChatBefore = true
            cell.configureCell(by: item, hasMyChatBefore: hasMyChatBefore) {
                guard var snapshot = self.dataSource?.snapshot() else { return }
                snapshot.reloadItems([item])
                self.view.setNeedsLayout()
            }
    
            
            return cell
        }
    }
}
