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

class MainCoordinator: MainBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    let tabBarViewModel = MainTabBarViewModel()
    
    lazy var usersCoordinator: UsersBaseCoordinator = UsersCoordinator()
    lazy var favoritesCoordinator: FavoritesBaseCoordinator = FavoritesCoordinator()
    lazy var aboutMeCoordinator: AboutMeBaseCoordinator = AboutMeCoordinator()
    lazy var deepLinkCoordinator: DeepLinkBaseCoordinator = DeepLinkCoordinator(mainBaseCoordinator: self)
    
    lazy var rootViewController: UIViewController  = UITabBarController()
    
    func start() -> UIViewController {
        
        let usersVC = usersCoordinator.start()
        //usersVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "homekit"), tag: 0)
        usersCoordinator.parentCoordinator = self
        
        let favoritesVC = favoritesCoordinator.start()
        //favoritesVC.tabBarItem = UITabBarItem(title: "Orders", image: UIImage(systemName: "doc.plaintext"), tag: 1)
        favoritesCoordinator.parentCoordinator = self
        
        let aboutMeVC = aboutMeCoordinator.start()
        //aboutMeVC.tabBarItem = UITabBarItem(title: "Orders", image: UIImage(systemName: "doc.plaintext"), tag: 2)
        aboutMeCoordinator.parentCoordinator = self
        
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
    
    func handleDeepLink(text: String, params: [String : Any]?) {
        deepLinkCoordinator.handleDeeplink(deepLink: text, params: params)
    }
    
    func resetToRoot() -> Self {
        usersCoordinator.resetToRoot(animated: false)
        moveTo(flow: .users(.list), userData: nil)
        return self
    }
}
