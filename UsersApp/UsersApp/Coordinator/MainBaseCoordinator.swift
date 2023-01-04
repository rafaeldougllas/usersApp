//
//  MainBaseCoordinator.swift
//  UsersApp
//
//  Created by Rafael Douglas on 24/12/22.
//

import Foundation

protocol MainBaseCoordinator: Coordinator {
    var usersCoordinator: UsersBaseCoordinator { get }
    var favoritesCoordinator: FavoritesBaseCoordinator { get }
    var aboutMeCoordinator: AboutMeBaseCoordinator { get }
    var deepLinkCoordinator: DeepLinkBaseCoordinator { get }
    func handleDeepLink(text: String, params: [String : Any]?)
}

protocol UsersBaseCoordinated {
    var coordinator: UsersBaseCoordinator? { get }
}

protocol FavoritesBaseCoordinated {
    var coordinator: FavoritesBaseCoordinator? { get }
}

protocol AboutMeBaseCoordinated {
    var coordinator: AboutMeBaseCoordinator? { get }
}
