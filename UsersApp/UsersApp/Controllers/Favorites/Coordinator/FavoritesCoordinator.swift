//
//  FavoritesCoordinator.swift
//  UsersApp
//
//  Created by Rafael Douglas on 24/12/22.
//

import UIKit

protocol FavoritesBaseCoordinator: Coordinator {}

class FavoritesCoordinator: FavoritesBaseCoordinator {

    var parentCoordinator: MainBaseCoordinator?
    let tabBarViewModel = MainTabBarViewModel()
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let navFavorites = tabBarViewModel.getFavoritedUsersNavigationController(coordinator: self)
        navFavorites.navigationBar.standardAppearance = tabBarViewModel.getNavigationBarAppearance()
        tabBarViewModel.setupNavigationBarAdditionalAppearance(navController: navFavorites)
        rootViewController = navFavorites
        return rootViewController
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]? = nil) {
        switch flow {
        case .favorites(let screen):
            handleFavoritesFlow(for: screen, userData: userData)
        default:
            parentCoordinator?.moveTo(flow: flow, userData: userData)
        }
    }
    
    private func handleFavoritesFlow(for screen: FavoritesScreen, userData: [String: Any]?) {
        switch screen {
        case .list:
            resetToRoot(animated: false)
        case .detail:
            goToUserDetail(userData: userData)
        }
    }
    
    func goToUserDetail(userData: [String: Any]?) {
        parentCoordinator?.moveTo(flow: .users(.detail), userData: userData)
    }
    
    @discardableResult
    func resetToRoot(animated: Bool) -> Self {
        navigationRootViewController?.popToRootViewController(animated: animated)
        return self
    }
}
