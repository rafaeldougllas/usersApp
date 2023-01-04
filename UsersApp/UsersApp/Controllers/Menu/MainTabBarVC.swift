//
//  MainTabBarVC.swift
//  UsersApp
//
//  Created by Rafael Douglas on 17/12/22.
//
/*
import UIKit

class MainTabBarVC: UITabBarController {
    
    let viewModel: MainTabBarViewModelProtocol = MainTabBarViewModel()
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        setupTabBar()
    }
    
    // MARK: Methods
    func setupViewControllers() {
        let usersNav = viewModel.getUsersNavigationController()
        setupNavigationBar(for: usersNav)
            
        let favoritedNav = viewModel.getFavoritedUsersNavigationController()
        setupNavigationBar(for: favoritedNav)
        
        let aboutMeNav = viewModel.getAboutMeNavigationController()
        setupNavigationBar(for: aboutMeNav)
        
        viewControllers = [usersNav, favoritedNav, aboutMeNav]
    }
    
    func setupTabBar() {
        tabBar.standardAppearance = viewModel.getTabBarAppearance()
    }
    
    func setupNavigationBar(for navController: UINavigationController) {
        navController.navigationBar.standardAppearance = viewModel.getNavigationBarAppearance()
        viewModel.setupNavigationBarAdditionalAppearance(navController: navController)
    }
}
*/
