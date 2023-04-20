//
//  MainCoordinatorProtocol.swift
//  UsersApp
//
//  Created by Rafael Douglas on 24/12/22.
//

import UIKit

protocol MainCoordinatorProtocol: CoordinatorProtocol {
    var usersCoordinator: UsersCoordinatorProtocol { get }
    var favoritesCoordinator: FavoritesCoordinatorProtocol { get }
    var aboutMeCoordinator: AboutMeCoordinatorProtocol { get }
    var deepLinkCoordinator: DeepLinkCoordinatorProtocol { get }
    
    func handleDeepLink(text: String, params: [String : Any]?)
}
