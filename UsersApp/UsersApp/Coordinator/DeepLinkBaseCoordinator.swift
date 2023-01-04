//
//  DeepLinkBaseCoordinator.swift
//  UsersApp
//
//  Created by Rafael Douglas on 24/12/22.
//

import Foundation

protocol DeepLinkBaseCoordinator: FlowCoordinator {
    func handleDeeplink(deepLink: String, params: [String : Any]?)
}
