//
//  UsersVC.swift
//  UsersApp
//
//  Created by Rafael Douglas on 17/12/22.
//

import UIKit

final class UsersVC: UIViewController {
    
    // MARK: - Properties
    var viewModel: UsersViewModelProtocol
    var usersView: UsersViewProtocol
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        populateView()
    }
    
    override func loadView() {
        super.loadView()
        setupUserView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usersView.delegate = self
        populateView()
    }
    
    // MARK: - Initializers
    init(usersView: UsersViewProtocol,
         viewModel: UsersViewModelProtocol) {
        self.usersView = usersView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupVC() {
        title = viewModel.getPageTitle()
    }
    
    private func setupUserView() {
        usersView.setupTableViewProtocols(delegate: self,
                                          dataSource: self)
        view = usersView
    }
    
    private func populateView() {
        viewModel.fetchUsers()
    }
    
    private func presentError(title: String,
                              message: String,
                              btnTitle: String) {
        guard let navigation = self.navigationController else { return }
        
        let dialogMessage = UIAlertController(title: title,
                                              message: message,
                                              preferredStyle: .alert)
        
        let ok = UIAlertAction(title: btnTitle,
                               style: .default,
                               handler: { (action) -> Void in
            navigation.dismiss(animated: false, completion: nil)
        })
        
        dialogMessage.addAction(ok)
        
        navigation.present(dialogMessage, animated: true, completion: nil)
    }
}
// MARK: - UITableViewDataSource
extension UsersVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = viewModel.numberOfRows()
        if numberOfRows == 0 {
            tableView.setEmptyMessage(viewModel.getEmptyRowsText())
        } else {
            tableView.restore()
        }
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.className,
                                                       for: indexPath as IndexPath) as? UserTableViewCell,
              let user = viewModel.modelAt(indexPath.row) else { return UITableViewCell() }
        cell.setup(indexPath: indexPath, delegate: self, user: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getHeightForRow()
    }
}
// MARK: - UITableViewDelegate
extension UsersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(indexPath: indexPath)
    }
}
// MARK: - UserTableViewCellDelegate
extension UsersVC: UserTableViewCellDelegate {
    func addFavoriteTapped(user: UserProfile, indexPath: IndexPath) {
        viewModel.addFavorited(user: user, indexPath: indexPath)
    }
    
    func removeFavoriteTapped(user: UserProfile, indexPath: IndexPath) {
        viewModel.removeFavorited(user: user, indexPath: indexPath)
    }
}

//MARK: UsersViewDelegate
extension UsersVC: UsersViewDelegate {
    func fetchContactsTableData() {
        viewModel.fetchUsers()
    }
}
//MARK: UsersViewDelegate
extension UsersVC: UsersViewModelDelegate {
    func showError(title: String,
                   message: String,
                   btnTitle: String) {
        presentError(title: title,
                     message: message,
                     btnTitle: btnTitle)
    }
    
    func updateUsersView(with state: StateView) {
        switch state {
        case .loading:
            usersView.startRefresh()
        case .loaded:
            usersView.stopRefresh()
        case .hasData:
            usersView.reloadTableData()
        }
    }
}
