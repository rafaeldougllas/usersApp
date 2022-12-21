//
//  SuccessAPI.swift
//  UsersAppTests
//
//  Created by Rafael Douglas on 19/12/22.
//

import Foundation
@testable import UsersApp

class SuccessAPI: APIProtocols {
    var fetchedUsers = [UserProfile]()
    var fetchUsersCalled = false
    
    func fetchUsers(completion: @escaping (Result<[UserProfile], Error>) -> Void) {
        for index in 1...20 {
            fetchedUsers.append(.fixture(id: index))
        }
        fetchUsersCalled = true
        completion(.success(fetchedUsers))
    }
}
