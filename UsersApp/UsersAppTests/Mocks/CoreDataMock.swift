//
//  CoreDataMock.swift
//  UsersAppTests
//
//  Created by Rafael Douglas on 19/12/22.
//

@testable import UsersApp
import XCTest

final class CoreDataMock: UserCoreDataProtocol {
    
    var delegates: [UserCoreDataDelegate] = [UserCoreDataDelegate]()
    var favoriteUsers: [FavoriteUser] = [FavoriteUser]()
    var loadedFavoriteUsers = [UserProfile]()
    
    func loadUsersFavorited() -> [UsersApp.UserProfile] {
        for id in 1...5 {
            loadedFavoriteUsers.append(.fixture(id: id))
        }
        return loadedFavoriteUsers
    }
    
    func isFavorite(id: Int) -> Bool {
        return false
    }
    
    func addFavorite(_ user: UserProfile) {
        loadedFavoriteUsers.append(user)
    }
    
    func removeFavorite(id: Int) {
        loadedFavoriteUsers = loadedFavoriteUsers.filter { $0.id != id }
    }
}
