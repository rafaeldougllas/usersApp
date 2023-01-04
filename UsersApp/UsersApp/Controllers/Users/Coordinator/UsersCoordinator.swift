//
//  UsersCoordinator.swift
//  UsersApp
//
//  Created by Rafael Douglas on 24/12/22.
//

import UIKit

protocol UsersBaseCoordinator: Coordinator {}

class UsersCoordinator: UsersBaseCoordinator {
    
    let tabBarViewModel = MainTabBarViewModel()
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let navUsers = tabBarViewModel.getUsersNavigationController(coordinator: self)
        navUsers.navigationBar.standardAppearance = tabBarViewModel.getNavigationBarAppearance()
        tabBarViewModel.setupNavigationBarAdditionalAppearance(navController: navUsers)
        rootViewController = navUsers
        return rootViewController
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]? = nil) {
        switch flow {
        case .users(let screen):
            handleUsersFlow(for: screen, userData: userData)
        default:
            parentCoordinator?.moveTo(flow: flow, userData: userData)
        }
    }
    
    private func handleUsersFlow(for screen: UsersScreen, userData: [String: Any]?) {
        switch screen {
        case .list:
            resetToRoot(animated: false)
        case .detail:
            resetToRoot(animated: false)
            guard let user = userData?["user"] as? UserProfile else { return }
            goToUserDetail(user: user)
        }
    }
    
    func goToUserDetail(user: UserProfile) {
        let userDetailVC = UserDetailVC(user: user, coordinator: self)
        navigationRootViewController?.pushViewController(userDetailVC, animated: true)
    }
    
    @discardableResult
    func resetToRoot(animated: Bool) -> Self {
        navigationRootViewController?.popToRootViewController(animated: animated)
        return self
    }
}
