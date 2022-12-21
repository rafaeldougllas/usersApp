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
    var favoriteUsers: [FavoriteUser] { get set }
    func loadFavoriteUsers(completion: @escaping () -> ())
    func isFavorite(id: Int) -> Bool
    func addFavorite(_ user: UserProfile)
    func removeFavorite(id: Int)
    func saveChanges()
}

public class UserCoreData: UserCoreDataProtocol {
    static let shared = UserCoreData()
    
    var managedContext: NSManagedObjectContext?
    
    public var delegates = [UserCoreDataDelegate]()
    public var favoriteUsers = [FavoriteUser]() {
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
    
    public func loadFavoriteUsers(completion: @escaping () -> ()) {
        guard let managedContext = managedContext else { return }
        
        let fetchRequest: NSFetchRequest<FavoriteUser> = FavoriteUser.fetchRequest()
        
        do {
            self.favoriteUsers = try managedContext.fetch(fetchRequest)
            completion()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
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
        self.favoriteUsers.append(newFavoriteUser)
    }
    
    public func removeFavorite(id: Int) {
        
        guard let managedContext = managedContext else { return }
        
        var count = 0
        
        for user in self.favoriteUsers {
            if user.id == id {
                let removeUser = user
                self.favoriteUsers.remove(at: count)
                managedContext.delete(removeUser)
            }
            count += 1
        }
        
    }
    
    public func saveChanges() {
        do {
            try self.managedContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
