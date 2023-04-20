//
//  UsersViewModel.swift
//  UsersApp
//
//  Created by Rafael Douglas on 17/12/22.
//

import Foundation

protocol UsersViewModelDelegate: AnyObject {
    func updateUsersView(with state: StateView)
    func showError(title: String,
                   message: String,
                   btnTitle: String)
}

protocol UsersViewModelProtocol {
    var coordinator: UsersCoordinatorProtocol? { get set }
    var delegate: UsersViewModelDelegate? { get set }
    
    func getHeightForRow() -> CGFloat
    func getPageTitle() -> String
    func fetchUsers()
    func numberOfRows() -> Int
    func getEmptyRowsText() -> String
    func modelAt(_ index: Int) -> UserProfile?
    func didSelect(indexPath: IndexPath)
    func getUsersArr() -> [UserProfile]
    func addFavorited(user: UserProfile, indexPath: IndexPath)
    func removeFavorited(user: UserProfile, indexPath: IndexPath)
}

final class UsersViewModel: UsersViewModelProtocol {
    //MARK: - Properties
    weak var coordinator: UsersCoordinatorProtocol?
    weak var delegate: UsersViewModelDelegate?
    
    private var heightForRow: CGFloat = 112
    private let usersUseCase: UsersUseCaseProtocol
    private var coreData: UserCoreDataProtocol
    private var users: [UserProfile] = [UserProfile]()
    private enum texts {
        static let pageTitle = "users.page.title".localized()
        static let alertTitle = "error.alert.title".localized()
        static let alertMessage = "error.alert.description".localized()
        static let alertBtnTitle = "error.alert.btn.title".localized()
        static let emptyUsersRows = "users.table.empty".localized()
    }
    
    //MARK: - Initialization
    init(usersUseCase: UsersUseCaseProtocol,
         coreData: UserCoreDataProtocol = UserCoreData.shared) {
        self.usersUseCase = usersUseCase
        self.coreData = coreData
    }
    
    //MARK: - Methods
    func getHeightForRow() -> CGFloat {
        heightForRow
    }
    
    func getPageTitle() -> String {
        texts.pageTitle
    }
    
    func fetchUsers() {
        delegate?.updateUsersView(with: .loading)
        
        usersUseCase.fetchUsers { [weak self] result in
            guard let self = self else { return }
            self.delegate?.updateUsersView(with: .loaded)
            
            switch result {
            case let .success((userResponse, _)):
                self.users = userResponse.data
                self.setCoreDataFavoritedUsersInArr()
            case .failure(_):
                self.delegate?.showError(title: texts.alertTitle,
                                         message: texts.alertMessage,
                                         btnTitle: texts.alertBtnTitle)
            }
            self.delegate?.updateUsersView(with: .hasData)
        }
    }
    
    func numberOfRows() -> Int {
        return users.count
    }
    
    func getEmptyRowsText() -> String {
        return texts.emptyUsersRows
    }
    
    func modelAt(_ index: Int) -> UserProfile? {
        return users[safe: index]
    }
    
    func didSelect(indexPath: IndexPath) {
        guard let user = modelAt(indexPath.row) else { return }
        coordinator?.moveTo(flow: .users(.detail), userData: ["user": user])
    }
    
    func getUsersArr() -> [UserProfile] {
        return users
    }
    
    private func updateFavoriteStatus(index: Int, isFavorite: Bool) {
        if modelAt(index) != nil {
            users[index].isFavorite = isFavorite
        }
    }
    
    //MARK: Core Data Methods
    private func setCoreDataFavoritedUsersInArr() {
        for (index, user) in users.enumerated() {
            users[index].isFavorite = coreData.isFavorite(id: user.id)
        }
    }
    
    func removeFavorited(user: UserProfile, indexPath: IndexPath) {
        coreData.removeFavorite(id: user.id)
        updateFavoriteStatus(index: indexPath.row, isFavorite: false)
        delegate?.updateUsersView(with: .hasData)
    }
    
    func addFavorited(user: UserProfile, indexPath: IndexPath) {
        coreData.addFavorite(user)
        updateFavoriteStatus(index: indexPath.row, isFavorite: true)
        delegate?.updateUsersView(with: .hasData)
    }
}

//MARK: UserCoreDataDelegate
extension UsersViewModel: UserCoreDataDelegate {
    func updateFavoriteUsers() {
        setCoreDataFavoritedUsersInArr()
    }
}
