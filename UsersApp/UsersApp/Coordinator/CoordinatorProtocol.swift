//
//  CoordinatorProtocol.swift
//  UsersApp
//
//  Created by Rafael Douglas on 24/12/22.
//

import UIKit

protocol FlowCoordinatorProtocol: AnyObject {
    var parentCoordinator: MainCoordinatorProtocol? { get set }
}

protocol CoordinatorProtocol: FlowCoordinatorProtocol {
    var rootViewController: UIViewController { get set }
    
    func start() -> UIViewController
    func moveTo(flow: AppFlow, userData: [String: Any]?)
    @discardableResult func resetToRoot(animated: Bool) -> Self
}

extension CoordinatorProtocol {
    var navigationRootViewController: UINavigationController? {
        get {
            (rootViewController as? UINavigationController)
        }
    }
    
    func resetToRoot(animated: Bool) -> Self {
        navigationRootViewController?.popToRootViewController(animated: animated)
        return self
    }
}
