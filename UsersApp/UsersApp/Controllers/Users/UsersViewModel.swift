//
//  UsersViewModel.swift
//  UsersApp
//
//  Created by Rafael Douglas on 17/12/22.
//

import UIKit

protocol UsersViewModelProtocol {
    var heightForRow: CGFloat { get set }
    var APIManager: APIProtocols { get }
    var coreData: UserCoreDataProtocol { get }
    
    func getPageTitle() -> String
    func setupTableViewProtocols(view: UsersView,
                                 delegate: UITableViewDelegate,
                                 dataSource: UITableViewDataSource)
    func reloadData(view: UsersView)
    func fetchUsers(completion: @escaping (Result<Void, Error>) -> ())
    func presentError(navigation: UINavigationController,
                      completion: (() -> Void)?)
    func numberOfRows() -> Int
    func getEmptyRowsText() -> String
    func modelAt(_ index: Int) -> UserProfile?
    func setUsersArr(users: [UserProfile])
    func getUsersArr() -> [UserProfile]
    func addFavorited(view: UsersView, user: UserProfile, indexPath: IndexPath)
    func removeFavorited(view: UsersView, user: UserProfile, indexPath: IndexPath)
    func saveChangesInCoreData()
}

class UsersViewModel: UsersViewModelProtocol {
    //MARK: - Properties
    public var heightForRow: CGFloat = 112
    let APIManager: APIProtocols
    var coreData: UserCoreDataProtocol
    private var users: [UserProfile] = [UserProfile]()
    private enum texts {
        static let pageTitle = "users.page.title".localized()
        static let alertTitle = "error.alert.title".localized()
        static let alertMessage = "error.alert.description".localized()
        static let alertBtnTitle = "error.alert.btn.title".localized()
        static let emptyUsersRows = "users.table.empty".localized()
    }
    
    //MARK: - Initialization
    init(apiManager: APIProtocols, coreData: UserCoreDataProtocol = UserCoreData.shared) {
        self.APIManager = apiManager
        self.coreData = coreData
    }
    
    //MARK: - Methods
    public func getPageTitle() -> String {
        return texts.pageTitle
    }
    
    public func setupTableViewProtocols(view: UsersView,
                                        delegate: UITableViewDelegate,
                                        dataSource: UITableViewDataSource) {
        view.setupTableViewProtocols(delegate: delegate,
                                     dataSource: dataSource)
    }
    
    public func reloadData(view: UsersView) {
        view.reloadTable()
    }
    
    public func fetchUsers(completion: @escaping (Result<Void, Error>) -> ()) {
        APIManager.fetchUsers(completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let users):
                self.setUsersArr(users: users)
                self.setCoreDataFavoritedUsersInArr()
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    public func presentError(navigation: UINavigationController,
                             completion: (() -> Void)? = nil) {
        let dialogMessage = UIAlertController(title: texts.alertTitle,
                                              message: texts.alertMessage,
                                              preferredStyle: .alert)
        
        let ok = UIAlertAction(title: texts.alertBtnTitle,
                               style: .default,
                               handler: { (action) -> Void in
                                navigation.dismiss(animated: false, completion: nil)
                               })
        
        dialogMessage.addAction(ok)
        
        navigation.present(dialogMessage, animated: true, completion: nil)
        completion?()
    }
    
    public func numberOfRows() -> Int {
        return users.count
    }
    
    public func getEmptyRowsText() -> String {
        return texts.emptyUsersRows
    }
    
    public func modelAt(_ index: Int) -> UserProfile? {
        return users[safe: index]
    }
    
    public func updateFavoriteStatus(index: Int, isFavorite: Bool) {
        if modelAt(index) != nil {
            users[index].isFavorite = isFavorite
        }
    }
    
    public func getUsersArr() -> [UserProfile] {
        return users
    }
    
    public func setUsersArr(users: [UserProfile]) {
        self.users = users
    }
    
    //MARK: Core Data Methods
    private func setCoreDataFavoritedUsersInArr() {
        for (index, user) in users.enumerated() {
            users[index].isFavorite = coreData.isFavorite(id: user.id)
        }
    }
    
    func removeFavorited(view: UsersView, user: UserProfile, indexPath: IndexPath) {
        coreData.removeFavorite(id: user.id)
        updateFavoriteStatus(index: indexPath.row, isFavorite: false)
        saveChangesInCoreData()
        reloadData(view: view)
    }
    
    func addFavorited(view: UsersView, user: UserProfile, indexPath: IndexPath) {
        coreData.addFavorite(user)
        updateFavoriteStatus(index: indexPath.row, isFavorite: true)
        saveChangesInCoreData()
        reloadData(view: view)
    }
    
    func saveChangesInCoreData() {
        coreData.saveChanges()
    }
}

//MARK: UserCoreDataDelegate
extension UsersViewModel: UserCoreDataDelegate {
    func updateFavoriteUsers() {
        setCoreDataFavoritedUsersInArr()
    }
}
