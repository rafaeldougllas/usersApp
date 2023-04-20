//
//  Endpoints.swift
//  UsersApp
//
//  Created by Rafael Douglas on 18/12/22.
//

import Foundation

public enum Endpoints {
    private var baseURL: String { return "https://reqres.in/api/users/" }
    
    case users
    case userDetail(Int)
    
    var fullPath: String {
        var endpoint:String
        switch self {
        case .users:
            endpoint = "?per_page=12"
        case .userDetail(let id):
            endpoint = "/user/\(id)"
        }
        return baseURL + endpoint
    }
    
    var url: URL {
        guard let url = URL(string: fullPath) else {
            preconditionFailure("The url used in \(Endpoints.self) is not valid")
        }
        return url
    }
}
