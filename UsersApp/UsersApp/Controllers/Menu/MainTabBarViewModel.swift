//
//  MainTabBarViewModel.swift
//  UsersApp
//
//  Created by Rafael Douglas on 17/12/22.
//

import UIKit

protocol MainTabBarViewModelProtocol {
    func getTabBarAppearance() -> UITabBarAppearance
    func getNavigationBarAppearance() -> UINavigationBarAppearance
    func setupNavigationBarAdditionalAppearance(navController: UINavigationController)
    func getUsersNavigationController(coordinator: UsersCoordinatorProtocol) -> UINavigationController
    func getFavoritedUsersNavigationController(coordinator: FavoritesCoordinatorProtocol) -> UINavigationController
    func getAboutMeNavigationController(coordinator: AboutMeCoordinatorProtocol) -> UINavigationController
}

final class MainTabBarViewModel: MainTabBarViewModelProtocol {    
    //MARK: - Methods
    func getTabBarAppearance() -> UITabBarAppearance {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .primary
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10),
                                                           NSAttributedString.Key.foregroundColor: UIColor.secondary]
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10),
                                                             NSAttributedString.Key.foregroundColor: UIColor.tertiary]
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        
        return tabBarAppearance
    }
    
    func getNavigationBarAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.tertiary,
            NSAttributedString.Key.font: UIFont(name: "OpenSans", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        appearance.backgroundColor = .primary
        return appearance
    }
    
    func setupNavigationBarAdditionalAppearance(navController: UINavigationController) {
        navController.navigationBar.tintColor = .secondary
        navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
        navController.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        navController.navigationBar.layer.shadowRadius = 1
        navController.navigationBar.layer.shadowOpacity = 0.15
    }
    
    func getUsersNavigationController(coordinator: UsersCoordinatorProtocol) -> UINavigationController {
        
        let usersNav = UINavigationController(rootViewController: ControllersFactory.makeUsersVC(coordinator: coordinator))
        usersNav.tabBarItem = UITabBarItem(title: "Users",
                                           image: UIImage(systemName: "person.3")?.withTintColor(.secondary,
                                                                                                 renderingMode: .alwaysOriginal),
                                           selectedImage: UIImage(systemName: "person.3.fill")?.withTintColor(.tertiary,
                                                                                                              renderingMode: .alwaysOriginal))
        usersNav.tabBarItem.tag = 0
        return usersNav
    }
    
    func getFavoritedUsersNavigationController(coordinator: FavoritesCoordinatorProtocol) -> UINavigationController {
        
        let favoritesNav = UINavigationController(rootViewController: ControllersFactory.makeFavoritesVC(coordinator: coordinator))
        favoritesNav.tabBarItem = UITabBarItem(title: "Favoritos",
                                               image: UIImage(systemName: "star.circle")?.withTintColor(.secondary,
                                                                                                        renderingMode: .alwaysOriginal),
                                               selectedImage: UIImage(systemName: "star.circle.fill")?.withTintColor(.tertiary,
                                                                                                                     renderingMode: .alwaysOriginal))
        favoritesNav.tabBarItem.tag = 1
        return favoritesNav
    }
    
    func getAboutMeNavigationController(coordinator: AboutMeCoordinatorProtocol) -> UINavigationController {
        
        let aboutMeNav = UINavigationController(rootViewController: ControllersFactory.makeAboutMeVC(coordinator: coordinator))
        aboutMeNav.tabBarItem = UITabBarItem(title: "About Me",
                                             image: UIImage(systemName: "person.circle")?.withTintColor(.secondary,
                                                                                                        renderingMode: .alwaysOriginal),
                                             selectedImage: UIImage(systemName: "person.circle.fill")?.withTintColor(.tertiary,
                                                                                                                     renderingMode: .alwaysOriginal))
        aboutMeNav.tabBarItem.tag = 2
        return aboutMeNav
    }
}
