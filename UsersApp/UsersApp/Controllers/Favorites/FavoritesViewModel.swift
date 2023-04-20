//
//  AboutMeViewModel.swift
//  UsersApp
//
//  Created by Rafael Douglas on 18/12/22.
//

import UIKit

protocol FavoritesViewModelDelegate: AnyObject {
    func updateUsersView(with state: StateView)
    func showError(title: String,
                   message: String,
                   btnTitle: String)
}

protocol FavoritesViewModelProtocol {
    var coordinator: FavoritesCoordinatorProtocol? { get set }
    var delegate: FavoritesViewModelDelegate? { get set }
    
    func getHeightForRow() -> CGFloat
    func getPageTitle() -> String
    func getEmptyRowsText() -> String
    func numberOfRows() -> Int
    func modelAt(_ index: Int) -> UserProfile?
    func didSelect(indexPath: IndexPath)
    func loadFavoritedUsersFromCoreData()
    func removeFavorited(at index: Int)
}

final class FavoritesViewModel: FavoritesViewModelProtocol {
    //MARK: - Properties
    weak var coordinator: FavoritesCoordinatorProtocol?
    weak var delegate: FavoritesViewModelDelegate?
    
    private let heightForRow: CGFloat = 112
    private var coreData: UserCoreDataProtocol
    private var favoriteUsers = [UserProfile]()
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
    func getHeightForRow() -> CGFloat {
        heightForRow
    }
    
    func getPageTitle() -> String {
        return texts.pageTitle
    }
    
    func getEmptyRowsText() -> String {
        return texts.emptyFavoritedUsersRows
    }
    
    func numberOfRows() -> Int {
        return favoriteUsers.count
    }
    
    func modelAt(_ index: Int) -> UserProfile? {
        return favoriteUsers[safe: index]
    }
    
    func didSelect(indexPath: IndexPath) {
        guard let user = modelAt(indexPath.row) else { return }
        coordinator?.moveTo(flow: .favorites(.detail), userData: ["user": user])
    }
    
    //MARK: Core Data Methods
    func loadFavoritedUsersFromCoreData() {
        guard newCoreDataChanges else {
            delegate?.updateUsersView(with: .loaded)
            delegate?.updateUsersView(with: .hasData)
            return
        }
        delegate?.updateUsersView(with: .loading)
        favoriteUsers = coreData.loadUsersFavorited()
        delegate?.updateUsersView(with: .loaded)
        delegate?.updateUsersView(with: .hasData)
        newCoreDataChanges = false
    }
    
    func removeFavorited(at index: Int) {
        if let favoriteUser = favoriteUsers[safe: index] {
            favoriteUsers.remove(at: index)
            coreData.removeFavorite(id: favoriteUser.id)
            delegate?.updateUsersView(with: .hasData)
        }
    }
}

//MARK: Update Delegate Protocol
extension FavoritesViewModel: UserCoreDataDelegate {
    func updateFavoriteUsers() {
        newCoreDataChanges = true
    }
}
