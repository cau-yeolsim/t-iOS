//
//  Coordinator.swift
//  
//
//  Created by kimchansoo on 2023/11/05.
//

import UIKit

public protocol CoordinatorDelegate: AnyObject {
    
    func didFinish(childCoordinator: Coordinator)
}

public protocol Coordinator: AnyObject {
    
    var delegate: CoordinatorDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    
    init(_ navigationController: UINavigationController)

    func start()
    func finish()
    func popViewController()
    func dismissViewController()
    func presentErrorAlert(title: String?, message: String?, handler: (() -> Void)?)
}

public extension Coordinator {
    
    func finish() {
        childCoordinators.removeAll()
        delegate?.didFinish(childCoordinator: self)
    }
    
    func popViewController() {
        self.navigationController.popViewController(animated: true)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: true)
    }
    
    func presentErrorAlert(
        title: String? = nil,
        message: String? = "오류가 발생했습니다.\n잠시 후 다시 시도해주세요.",
        handler: (() -> Void)? = nil
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            .appendingAction(title: "확인", handler: handler)
        
        navigationController.present(alertController, animated: true)
    }
}

