//
//  DeepLinkCoordinator.swift
//  UsersApp
//
//  Created by Rafael Douglas on 24/12/22.
//

import Foundation

final class DeepLinkCoordinator: DeepLinkCoordinatorProtocol {
    
    func handleDeeplink(deepLink: String, params: [String : Any]?) {
        if let safeRoute = DeepLinkOptions(rawValue: deepLink) {
            switch safeRoute {
            case .users:
                parentCoordinator?.moveTo(flow: .users(.list), userData: params)
            case .favorites:
                parentCoordinator?.moveTo(flow: .favorites(.list), userData: params)
            case .aboutMe:
                parentCoordinator?.moveTo(flow: .aboutMe(.home), userData: params)
            }
            return
        }
        parentCoordinator?.moveTo(flow: .users(.list), userData: params)
    }
    
    var parentCoordinator: MainCoordinatorProtocol?
}
