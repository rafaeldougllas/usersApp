//
//  UsersUseCase.swift
//  UsersApp
//
//  Created by Rafael Douglas Sousa Barreto Dos Santos on 06/04/23.
//

import Foundation

protocol UsersUseCaseProtocol {
    var usersURL: String { get }
    
    typealias completion = (Result<(UsersResponse, HTTPURLResponse), Error>) -> Void
    func fetchUsers(completion: @escaping completion)
}

final class UsersUseCase {
    private let client: HttpClientProtocol
    let usersURL = Endpoints.users.fullPath
    
    init(client: HttpClientProtocol) {
        self.client = client
    }
}
// MARK: UsersUseCaseProtocol
extension UsersUseCase: UsersUseCaseProtocol {
    func fetchUsers(completion: @escaping completion) {
        guard let url = URL(string: usersURL) else {
            return completion(.failure(HttpCustomError.invalidURL))
        }
        
        client.fetch(url: url) { (result: Result<(UsersResponse, HTTPURLResponse), Error>) in
            switch result {
            case let .success((users, response)):
                let successBody = (users, response)
                completion(.success(successBody))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
