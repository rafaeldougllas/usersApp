//
//  CoordinatorFactory.swift
//  UsersApp
//
//  Created by Rafael Douglas Sousa Barreto Dos Santos on 20/04/23.
//

import UIKit

protocol CoordinatorFactoryProtocol {
    static func makeMainCoordinator() -> MainCoordinatorProtocol
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    static func makeMainCoordinator() -> MainCoordinatorProtocol {
        let tabBarViewModel: MainTabBarViewModelProtocol = MainTabBarViewModel()
        let usersCoordinator: UsersCoordinatorProtocol = UsersCoordinator()
        let favoritesCoordinator: FavoritesCoordinatorProtocol = FavoritesCoordinator()
        let aboutMeCoordinator: AboutMeCoordinatorProtocol = AboutMeCoordinator()
        let deepLinkCoordinator: DeepLinkCoordinatorProtocol = DeepLinkCoordinator()
        let rootViewController: UIViewController = UITabBarController()
        
        let mainCoordinator = MainCoordinator(tabBarViewModel: tabBarViewModel,
                                              usersCoordinator: usersCoordinator,
                                              favoritesCoordinator: favoritesCoordinator,
                                              aboutMeCoordinator: aboutMeCoordinator,
                                              deepLinkCoordinator: deepLinkCoordinator,
                                              rootViewController: rootViewController)
        return mainCoordinator
    }
}
