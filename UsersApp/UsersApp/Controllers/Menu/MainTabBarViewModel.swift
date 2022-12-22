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
    func getUsersNavigationController() -> UINavigationController
    func getFavoritedUsersNavigationController() -> UINavigationController
    func getAboutMeNavigationController() -> UINavigationController
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
    
    func getUsersNavigationController() -> UINavigationController {
        let apiManager = APIManager()
        let usersViewModel = UsersViewModel(apiManager: apiManager)
        let usersVC = UsersVC(viewModel: usersViewModel)
        let usersNav = UINavigationController(rootViewController: usersVC)
        usersNav.tabBarItem = UITabBarItem(title: "Users",
                                           image: UIImage(systemName: "person.3")?.withTintColor(.secondary,
                                                                                                 renderingMode: .alwaysOriginal),
                                           selectedImage: UIImage(systemName: "person.3.fill")?.withTintColor(.tertiary,
                                                                                                              renderingMode: .alwaysOriginal))
        return usersNav
    }
    
    func getFavoritedUsersNavigationController() -> UINavigationController {
        let favoritesViewModel = FavoritesViewModel()
        let favoritesNav = UINavigationController(rootViewController: FavoritesVC(viewModel: favoritesViewModel))
        favoritesNav.tabBarItem = UITabBarItem(title: "Favoritos",
                                               image: UIImage(systemName: "star.circle")?.withTintColor(.secondary,
                                                                                                        renderingMode: .alwaysOriginal),
                                               selectedImage: UIImage(systemName: "star.circle.fill")?.withTintColor(.tertiary,
                                                                                                                     renderingMode: .alwaysOriginal))
        return favoritesNav
    }
    
    func getAboutMeNavigationController() -> UINavigationController {
        let aboutMeViewModel = AboutMeViewModel()
        let aboutMeNav = UINavigationController(rootViewController: AboutMeVC(viewModel: aboutMeViewModel))
        aboutMeNav.tabBarItem = UITabBarItem(title: "About Me",
                                             image: UIImage(systemName: "person.circle")?.withTintColor(.secondary,
                                                                                                        renderingMode: .alwaysOriginal),
                                             selectedImage: UIImage(systemName: "person.circle.fill")?.withTintColor(.tertiary,
                                                                                                                     renderingMode: .alwaysOriginal))
        return aboutMeNav
    }
}
