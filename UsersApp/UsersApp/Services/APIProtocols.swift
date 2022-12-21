//
//  APIProtocols.swift
//  UsersApp
//
//  Created by Rafael Douglas on 18/12/22.
//

import Foundation

protocol GenericService: AnyObject {
    typealias completion<T> = (Result<T, Error>) -> Void
}

protocol APIProtocols: GenericService {
    func fetchUsers(completion: @escaping completion<[UserProfile]>)
}
