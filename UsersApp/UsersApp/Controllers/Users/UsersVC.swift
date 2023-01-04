//
//  UsersVC.swift
//  UsersApp
//
//  Created by Rafael Douglas on 17/12/22.
//

import UIKit

class UsersVC: UIViewController, UsersBaseCoordinated {
    
    // MARK: - Properties
    let viewModel: UsersViewModelProtocol
    let usersView = UsersView()
    var coordinator: UsersBaseCoordinator?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        populateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usersView.delegate = self
        populateView()
    }
    
    // MARK: - Initializers
    init(viewModel: UsersViewModelProtocol, coordinator: UsersBaseCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupVC() {
        view = usersView
        title = viewModel.getPageTitle()
    }
    
    private func populateView() {
        viewModel.setupTableViewProtocols(view: self.usersView,
                                          delegate: self,
                                          dataSource: self)
        viewModel.fetchUsers(completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success():
                self.viewModel.reloadData(view: self.usersView)
            case .failure(_):
                guard let navigation = self.navigationController else { return }
                self.viewModel.presentError(navigation: navigation, completion: nil)
            }
        })
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
        return viewModel.heightForRow
    }
}
// MARK: - UITableViewDelegate
extension UsersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = viewModel.modelAt(indexPath.row) else { return }
        coordinator?.moveTo(flow: .users(.detail), userData: ["user": user])
    }
}
// MARK: - UserTableViewCellDelegate
extension UsersVC: UserTableViewCellDelegate {
    func addFavoriteTapped(user: UserProfile, indexPath: IndexPath) {
        viewModel.addFavorited(view: usersView, user: user, indexPath: indexPath)
    }
    
    func removeFavoriteTapped(user: UserProfile, indexPath: IndexPath) {
        viewModel.removeFavorited(view: usersView, user: user, indexPath: indexPath)
    }
}

//MARK: UsersViewDelegate
extension UsersVC: UsersViewDelegate {
    func showRefreshControl() {
        viewModel.fetchUsers(completion: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.reloadData(view: self.usersView)
        })
    }
}
