//
//  UsersResponse.swift
//  UsersApp
//
//  Created by Rafael Douglas on 17/12/22.
//

struct UsersResponse: Decodable {
  let data: [UserProfile]
}
// MARK: Fixture
extension UsersResponse {
    static func fixture() -> UsersResponse {
        return .init(data: [.fixture(id: 1), .fixture(id: 2)])
    }
}
