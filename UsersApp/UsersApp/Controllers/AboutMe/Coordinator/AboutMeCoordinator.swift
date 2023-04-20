//
//  AboutMeCoordinator.swift
//  UsersApp
//
//  Created by Rafael Douglas on 24/12/22.
//

import UIKit

protocol AboutMeCoordinatorProtocol: CoordinatorProtocol {}

final class AboutMeCoordinator: AboutMeCoordinatorProtocol {

    var parentCoordinator: MainCoordinatorProtocol?
    let tabBarViewModel = MainTabBarViewModel()
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let navAboutMe = tabBarViewModel.getAboutMeNavigationController(coordinator: self)
        navAboutMe.navigationBar.standardAppearance = tabBarViewModel.getNavigationBarAppearance()
        tabBarViewModel.setupNavigationBarAdditionalAppearance(navController: navAboutMe)
        rootViewController = navAboutMe
        return rootViewController
    }
    
    func moveTo(flow: AppFlow, userData: [String : Any]? = nil) {
        switch flow {
        case .aboutMe(let screen):
            handleAboutMeFlow(for: screen, userData: userData)
        default:
            parentCoordinator?.moveTo(flow: flow, userData: userData)
        }
    }
    
    private func handleAboutMeFlow(for screen: AboutMeScreen, userData: [String: Any]?) {
        switch screen {
        case .home:
            resetToRoot(animated: false)
        }
    }
    
    @discardableResult
    func resetToRoot(animated: Bool) -> Self {
        navigationRootViewController?.popToRootViewController(animated: animated)
        return self
    }
}
