//
//  UserDetailViewModel.swift
//  UsersApp
//
//  Created by Rafael Douglas on 18/12/22.
//

import UIKit

protocol UserDetailViewModelProtocol {
    var coordinator: UsersCoordinatorProtocol? { get set }
    
    func getPageTitle() -> String
    func getUser() -> UserProfile
}

final class UserDetailViewModel: UserDetailViewModelProtocol {
    //MARK: - Properties
    weak var coordinator: UsersCoordinatorProtocol?
    
    private var user: UserProfile
    private enum texts {
        static let pageTitle = "userDetail.page.title".localized()
    }
    
    //MARK: - Initialization
    init(user: UserProfile) {
        self.user = user
    }
    
    //MARK: - Methods
    func getPageTitle() -> String {
        return texts.pageTitle
    }
    
    func getUser() -> UserProfile {
        return user
    }
}
