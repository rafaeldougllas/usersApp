//
//  UserDetailVC.swift
//  UsersApp
//
//  Created by Rafael Douglas on 18/12/22.
//

import UIKit

final class UserDetailVC: UIViewController {
    // MARK: - Properties
    let userDetailViewModel: UserDetailViewModelProtocol
    let userDetailView: UserDetailViewProtocol

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        populateView()
    }
    
    override func loadView() {
        setupUserDetailView()
    }
    
    // MARK: - Initializers
    init(userDetailView: UserDetailViewProtocol,
         userDetailViewModel: UserDetailViewModelProtocol) {
        self.userDetailView = userDetailView
        self.userDetailViewModel = userDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupVC() {
        title = userDetailViewModel.getPageTitle()
    }
    
    private func populateView() {
        userDetailView.populateView(user: userDetailViewModel.getUser())
    }
    
    private func setupUserDetailView() {
        view = userDetailView
    }
}
