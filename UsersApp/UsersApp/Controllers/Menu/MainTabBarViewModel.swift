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
    func getUsersNavigationController(coordinator: UsersBaseCoordinator) -> UINavigationController
    func getFavoritedUsersNavigationController(coordinator: FavoritesBaseCoordinator) -> UINavigationController
    func getAboutMeNavigationController(coordinator: AboutMeBaseCoordinator) -> UINavigationController
}

class MainTabBarViewModel: MainTabBarViewModelProtocol {
    //MARK: - Initialization
    init() {}
    
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
    
    func getUsersNavigationController(coordinator: UsersBaseCoordinator) -> UINavigationController {
        let apiManager = APIManager()
        let usersViewModel = UsersViewModel(apiManager: apiManager)
        let usersVC = UsersVC(viewModel: usersViewModel, coordinator: coordinator)
        let usersNav = UINavigationController(rootViewController: usersVC)
        usersNav.tabBarItem = UITabBarItem(title: "Users",
                                           image: UIImage(systemName: "person.3")?.withTintColor(.secondary,
                                                                                                 renderingMode: .alwaysOriginal),
                                           selectedImage: UIImage(systemName: "person.3.fill")?.withTintColor(.tertiary,
                                                                                                              renderingMode: .alwaysOriginal))
        usersNav.tabBarItem.tag = 0
        return usersNav
    }
    
    func getFavoritedUsersNavigationController(coordinator: FavoritesBaseCoordinator) -> UINavigationController {
        let favoritesViewModel = FavoritesViewModel()
        let favoritesVC = FavoritesVC(viewModel: favoritesViewModel, coordinator: coordinator)
        let favoritesNav = UINavigationController(rootViewController: favoritesVC)
        favoritesNav.tabBarItem = UITabBarItem(title: "Favoritos",
                                               image: UIImage(systemName: "star.circle")?.withTintColor(.secondary,
                                                                                                        renderingMode: .alwaysOriginal),
                                               selectedImage: UIImage(systemName: "star.circle.fill")?.withTintColor(.tertiary,
                                                                                                                     renderingMode: .alwaysOriginal))
        favoritesNav.tabBarItem.tag = 1
        return favoritesNav
    }
    
    func getAboutMeNavigationController(coordinator: AboutMeBaseCoordinator) -> UINavigationController {
        let aboutMeViewModel = AboutMeViewModel()
        let aboutMeVC = AboutMeVC(viewModel: aboutMeViewModel, coordinator: coordinator)
        let aboutMeNav = UINavigationController(rootViewController: aboutMeVC)
        aboutMeNav.tabBarItem = UITabBarItem(title: "About Me",
                                             image: UIImage(systemName: "person.circle")?.withTintColor(.secondary,
                                                                                                        renderingMode: .alwaysOriginal),
                                             selectedImage: UIImage(systemName: "person.circle.fill")?.withTintColor(.tertiary,
                                                                                                                     renderingMode: .alwaysOriginal))
        aboutMeNav.tabBarItem.tag = 2
        return aboutMeNav
    }
}
