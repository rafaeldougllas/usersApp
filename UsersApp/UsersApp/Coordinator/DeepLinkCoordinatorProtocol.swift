//
//  DeepLinkCoordinatorProtocol.swift
//  UsersApp
//
//  Created by Rafael Douglas on 24/12/22.
//

import Foundation

protocol DeepLinkCoordinatorProtocol: FlowCoordinatorProtocol {
    func handleDeeplink(deepLink: String, params: [String : Any]?)
}
