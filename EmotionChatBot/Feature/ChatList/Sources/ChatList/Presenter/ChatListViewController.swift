//
//  ViewController.swift
//  EmotionChatBot
//
//  Created by kimchansoo on 2023/11/04.
//

import UIKit

import RxSwift
import SnapKit

import Util

public final class ChatListViewController: BaseViewController, UIScrollViewDelegate {

    // MARK: - UI
    private lazy var chatPreviewsTableView: UITableView = {
        let tableView = UITableView()
        let rowHeight = 80.0
        tableView.register(ChatPreviewCell.self)
        tableView.separatorStyle = .none
        tableView.rowHeight = rowHeight
        return tableView
    }()

    
    // MARK: - Properties
    private let viewModel: ChatListViewModel
    
    private var dataSource: UITableViewDiffableDataSource<Section, ChatRoom>?
    
    // MARK: - Initializers
    
    public init(viewModel: ChatListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Override
    
    public override func configureHierarchy() {
        self.view.addSubview(chatPreviewsTableView)
    }
    
    public override func configureConstraints() {
        chatPreviewsTableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }

    }
    
    public override func configureAttributes() {
        configureNavigationController()
        self.dataSource = configureDataSource()
    }
    
    public override func bind() {
        let input = ChatListViewModel.Input(
            viewWillAppear: self.rx.viewWillAppear.asObservable(),
            itemSelected: self.chatPreviewsTableView.rx.itemSelected.map(\.row).asObservable(),
            createChatRoomButtonTapped: self.navigationItem.rightBarButtonItem!.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.chatList
            .compactMap { [weak self] chatList in
                self?.generateSnapshot(chatList)
            }
            .subscribe(onNext: { [weak self] snapshot in
                self?.dataSource?.apply(snapshot)
            })
            .disposed(by: disposeBag)
        
        chatPreviewsTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }

    // MARK: - Methods
    
}

private extension ChatListViewController {
    enum Section {
        case main
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, ChatRoom> {
        let dataSource = UITableViewDiffableDataSource<Section, ChatRoom>(
            tableView: chatPreviewsTableView,
            cellProvider: { (tableView, indexPath, chatRoom) -> UITableViewCell? in
                guard let cell: ChatPreviewCell = tableView.dequeueCell(ChatPreviewCell.self, for: indexPath)
                else {
                    return UITableViewCell()
                }
                cell.configureCell(chatRoom)
                return cell
            }
        )
        
        return dataSource
    }
    
    func generateSnapshot(_ after: [ChatRoom]) -> NSDiffableDataSourceSnapshot<Section, ChatRoom> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ChatRoom>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(after)
        return snapshot
    }
}

private extension ChatListViewController {
    func configureNavigationController() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "채팅"
        
        // 새로운 채팅방 생성 버튼 추가
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = addButton
    }
}
