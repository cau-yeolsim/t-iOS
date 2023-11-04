//
//  ViewController.swift
//  EmotionChatBot
//
//  Created by kimchansoo on 2023/11/04.
//

import UIKit


public final class ChatListViewController: UIViewController {

    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }


}

