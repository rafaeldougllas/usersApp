//
//  UserDetailViewModel.swift
//  UsersApp
//
//  Created by Rafael Douglas on 18/12/22.
//

import UIKit

protocol UserDetailViewModelProtocol {
    var user: UserProfile { get set }
    
    func getPageTitle() -> String
    func populateView(view: UserDetailView, completion: () -> ())
}

class UserDetailViewModel: UserDetailViewModelProtocol {
    //MARK: - Properties
    var user: UserProfile
    public enum texts {
        static let pageTitle = "userDetail.page.title".localized()
    }
    
    //MARK: - Initialization
    init(user: UserProfile) {
        self.user = user
    }
    
    //MARK: - Methods
    public func getPageTitle() -> String {
        return texts.pageTitle
    }
    
    public func populateView(view: UserDetailView, completion: () -> ()) {
        view.populateView(user: self.user)
        completion()
    }
}
