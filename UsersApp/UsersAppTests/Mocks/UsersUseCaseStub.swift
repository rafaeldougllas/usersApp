//
//  UsersUseCaseStub.swift
//  UsersAppTests
//
//  Created by Rafael Douglas Sousa Barreto Dos Santos on 11/04/23.
//

import Foundation

@testable import UsersApp

final class UsersUseCaseStub: UsersUseCaseProtocol {
    var usersURL: String = Endpoints.users.fullPath
    var isSuccess = false
    
    func fetchUsers(completion: @escaping (Result<(UsersResponse, HTTPURLResponse), Error>) -> Void) {
        if isSuccess {
            completion(successResult())
        } else {
            completion(.failure(NSError(domain: "Error", code: -1)))
        }
    }
    
    private func successResult() -> Result<(UsersResponse, HTTPURLResponse), Error> {
        let httpResponse = UsersManagerMock.mockResponse(reqURL: URL(string: usersURL)!,
                                                         isSuccess: true)
        let successTuple = (getUsersResponse(), httpResponse)
        return Result.success(successTuple)
    }
    
    private func getUsersResponse() -> UsersResponse {
        return .fixture()
    }
}
