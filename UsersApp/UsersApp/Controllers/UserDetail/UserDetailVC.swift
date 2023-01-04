//
//  UserDetailVC.swift
//  UsersApp
//
//  Created by Rafael Douglas on 18/12/22.
//

import UIKit

class UserDetailVC: UIViewController, UsersBaseCoordinated {
    // MARK: - Properties
    let user: UserProfile
    let userDetailViewModel: UserDetailViewModelProtocol
    let userDetailView = UserDetailView()
    var coordinator: UsersBaseCoordinator?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        populateView()
    }
    
    // MARK: - Initializers
    init(user: UserProfile, coordinator: UsersBaseCoordinator) {
        self.user = user
        self.userDetailViewModel = UserDetailViewModel(user: user)
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupVC() {
        view = userDetailView
        title = userDetailViewModel.getPageTitle()
    }
    
    private func populateView() {
        userDetailViewModel.populateView(view: self.userDetailView, completion: {})
    }
}
