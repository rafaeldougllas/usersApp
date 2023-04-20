//
//  MainCoordinator.swift
//  UsersApp
//
//  Created by Rafael Douglas on 24/12/22.
//

import UIKit

enum AppFlow {
    case users(UsersScreen)
    case favorites(FavoritesScreen)
    case aboutMe(AboutMeScreen)
}

enum UsersScreen {
    case list
    case detail
}

enum FavoritesScreen {
    case list
    case detail
}

enum AboutMeScreen {
    case home
}

final class MainCoordinator: MainCoordinatorProtocol {
    let tabBarViewModel: MainTabBarViewModelProtocol
    var parentCoordinator: MainCoordinatorProtocol?
    var usersCoordinator: UsersCoordinatorProtocol
    var favoritesCoordinator: FavoritesCoordinatorProtocol
    var aboutMeCoordinator: AboutMeCoordinatorProtocol
    var deepLinkCoordinator: DeepLinkCoordinatorProtocol
    var rootViewController: UIViewController
    
    init(tabBarViewModel: MainTabBarViewModelProtocol,
         usersCoordinator: UsersCoordinatorProtocol,
         favoritesCoordinator: FavoritesCoordinatorProtocol,
         aboutMeCoordinator: AboutMeCoordinatorProtocol,
         deepLinkCoordinator: DeepLinkCoordinatorProtocol,
         rootViewController: UIViewController = UITabBarController()) {
        self.tabBarViewModel = tabBarViewModel
        self.usersCoordinator = usersCoordinator
        self.favoritesCoordinator = favoritesCoordinator
        self.aboutMeCoordinator = aboutMeCoordinator
        self.deepLinkCoordinator = deepLinkCoordinator
        self.rootViewController = rootViewController
    }
    
    // MARK: - Methods
    func start() -> UIViewController {
        let usersVC = usersCoordinator.start()
        let favoritesVC = favoritesCoordinator.start()
        let aboutMeVC = aboutMeCoordinator.start()
        
        setupParentsCoordinator()
        
        (rootViewController as? UITabBarController)?.viewControllers = [usersVC, favoritesVC, aboutMeVC]
        (rootViewController as? UITabBarController)?.tabBar.standardAppearance = tabBarViewModel.getTabBarAppearance()
                
        return rootViewController
    }
        
    func moveTo(flow: AppFlow, userData: [String : Any]?) {
        switch flow {
        case .users:
            goToUsersFlow(flow, userData: userData)
        case .favorites:
            goToFavoritesFlow(flow, userData: userData)
        case .aboutMe:
            goToAboutMeFlow(flow, userData: userData)
        }
    }
    
    func handleDeepLink(text: String, params: [String : Any]?) {
        deepLinkCoordinator.handleDeeplink(deepLink: text, params: params)
    }
    
    func resetToRoot() -> Self {
        usersCoordinator.resetToRoot(animated: false)
        moveTo(flow: .users(.list), userData: nil)
        return self
    }
    
    // MARK: - Private Methods
    private func setupParentsCoordinator() {
        usersCoordinator.parentCoordinator = self
        favoritesCoordinator.parentCoordinator = self
        aboutMeCoordinator.parentCoordinator = self
        deepLinkCoordinator.parentCoordinator = self
    }
    
    private func goToUsersFlow(_ flow: AppFlow, userData: [String : Any]?) {
        usersCoordinator.moveTo(flow: flow, userData: userData)
        (rootViewController as? UITabBarController)?.selectedIndex = 0
    }
    
    private func goToFavoritesFlow(_ flow: AppFlow, userData: [String : Any]?) {
        favoritesCoordinator.moveTo(flow: flow, userData: userData)
        (rootViewController as? UITabBarController)?.selectedIndex = 1
    }
    
    private func goToAboutMeFlow(_ flow: AppFlow, userData: [String : Any]?) {
        aboutMeCoordinator.moveTo(flow: flow, userData: userData)
        (rootViewController as? UITabBarController)?.selectedIndex = 2
    }
}
