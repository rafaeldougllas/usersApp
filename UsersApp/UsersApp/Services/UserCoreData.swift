//
//  UserCoreData.swift
//  UsersApp
//
//  Created by Rafael Douglas on 18/12/22.
//

import CoreData
import UIKit

public protocol UserCoreDataDelegate: AnyObject {
    func updateFavoriteUsers()
}

public protocol UserCoreDataProtocol: AnyObject {
    var delegates: [UserCoreDataDelegate] { get set }
    
    func loadUsersFavorited() -> [UserProfile]
    func isFavorite(id: Int) -> Bool
    func addFavorite(_ user: UserProfile)
    func removeFavorite(id: Int)
}

public class UserCoreData: UserCoreDataProtocol {
    static let shared = UserCoreData()
    public var delegates = [UserCoreDataDelegate]()
    
    private var managedContext: NSManagedObjectContext?
    private var favoriteUsers = [FavoriteUser]() {
        didSet {
            delegates.forEach { delegate in
                delegate.updateFavoriteUsers()
            }
        }
    }
    
    private init() {
        managedContext = (UIApplication.shared.delegate as? AppDelegate)?
            .persistentContainer
            .viewContext
    }
        
    public func loadUsersFavorited() -> [UserProfile] {
        return favoriteUsers.map { (favoritedUser: FavoriteUser) in
            UserProfile(id: Int(favoritedUser.id),
                        email: favoritedUser.email ?? "",
                        icon: favoritedUser.icon ?? "",
                        firstName: favoritedUser.firstName ?? "",
                        lastName: favoritedUser.lastName ?? "",
                        isFavorite: true)
        }
    }
    
    public func isFavorite(id: Int) -> Bool {
        
        for user in self.favoriteUsers {
            if user.id == id {
                return true
            }
        }
        return false
    }
    
    public func addFavorite(_ user: UserProfile) {
        
        guard let managedContext = managedContext else { return }
        
        let newFavoriteUser = FavoriteUser(context: managedContext)
        newFavoriteUser.id = Int16(user.id)
        newFavoriteUser.email = user.email
        newFavoriteUser.icon = user.icon
        newFavoriteUser.firstName = user.firstName
        newFavoriteUser.lastName = user.lastName
        favoriteUsers.append(newFavoriteUser)
        
        saveChanges()
    }
    
    public func removeFavorite(id: Int) {
        
        guard let managedContext = managedContext else { return }
        
        var count = 0
        
        for user in favoriteUsers {
            if user.id == id {
                let removeUser = user
                favoriteUsers.remove(at: count)
                managedContext.delete(removeUser)
            }
            count += 1
        }
        saveChanges()
    }
    
    private func saveChanges() {
        do {
            try self.managedContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
