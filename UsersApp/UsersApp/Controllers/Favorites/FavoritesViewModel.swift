//
//  AboutMeViewModel.swift
//  UsersApp
//
//  Created by Rafael Douglas on 18/12/22.
//

import UIKit

protocol FavoritesViewModelProtocol {
    var heightForRow: CGFloat { get set }
    var coreData: UserCoreDataProtocol { get }
    var favoriteUsers: [UserProfile] { get set }
    
    func getPageTitle() -> String
    func setupTableViewProtocols(view: FavoritesView,
                                 delegate: UITableViewDelegate,
                                 dataSource: UITableViewDataSource)
    func numberOfRows() -> Int
    func getEmptyRowsText() -> String
    func modelAt(_ index: Int) -> UserProfile?
    func reloadData(view: FavoritesView)
    func loadFavoritedUsersFromCoreData(completion: @escaping () -> Void)
    func removeFavorited(at index: Int, completion: @escaping () -> Void)
}

class FavoritesViewModel: FavoritesViewModelProtocol {
    //MARK: - Properties
    public var heightForRow: CGFloat = 112
    var coreData: UserCoreDataProtocol
    var favoriteUsers = [UserProfile]()
    private var newCoreDataChanges = true
    private enum texts {
        static let pageTitle = "favorites.page.title".localized()
        static let emptyFavoritedUsersRows = "favorites.table.empty".localized()
    }
    
    //MARK: - Initialization
    init(coreData: UserCoreDataProtocol = UserCoreData.shared) {
        self.coreData = coreData
        coreData.delegates.append(self)
    }
    
    //MARK: - Methods
    public func getPageTitle() -> String {
        return texts.pageTitle
    }
    
    public func setupTableViewProtocols(view: FavoritesView,
                                        delegate: UITableViewDelegate,
                                        dataSource: UITableViewDataSource) {
        view.setupTableViewProtocols(delegate: delegate,
                                     dataSource: dataSource)
    }
    
    public func numberOfRows() -> Int {
        return favoriteUsers.count
    }
    
    public func getEmptyRowsText() -> String {
        return texts.emptyFavoritedUsersRows
    }
    
    public func modelAt(_ index: Int) -> UserProfile? {
        return favoriteUsers[safe: index]
    }
    
    public func reloadData(view: FavoritesView) {
        view.reloadTable()
    }
    
    //MARK: Core Data Methods
    public func loadFavoritedUsersFromCoreData(completion: @escaping () -> Void) {
        guard newCoreDataChanges else { return }
        
        favoriteUsers = coreData.favoriteUsers.map { (favoritedUser: FavoriteUser) in
            UserProfile(id: Int(favoritedUser.id),
                        email: favoritedUser.email ?? "",
                        icon: favoritedUser.icon ?? "",
                        firstName: favoritedUser.firstName ?? "",
                        lastName: favoritedUser.lastName ?? "",
                        isFavorite: true)
        }
        
        newCoreDataChanges = false
        completion()
    }
    
    public func removeFavorited(at index: Int, completion: @escaping () -> Void) {
        if let favoriteUser = favoriteUsers[safe: index] {
            favoriteUsers.remove(at: index)
            coreData.removeFavorite(id: favoriteUser.id)
        }
        completion()
    }
}

//MARK: Update Delegate Protocol
extension FavoritesViewModel: UserCoreDataDelegate {
    func updateFavoriteUsers() {
        newCoreDataChanges = true
    }
}
