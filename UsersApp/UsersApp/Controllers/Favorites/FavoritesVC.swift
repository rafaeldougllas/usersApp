//
//  FavoritesVC.swift
//  UsersApp
//
//  Created by Rafael Douglas on 18/12/22.
//

import UIKit

final class FavoritesVC: UIViewController {
    
    // MARK: - Properties
    var viewModel: FavoritesViewModelProtocol
    let favoritesView: FavoritesViewProtocol
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        populateView()
    }
    
    override func loadView() {
        super.loadView()
        setupFavoritesView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesView.delegate = self
        populateView()
    }
    
    // MARK: - Initializers
    init(favoritesView: FavoritesViewProtocol,
         viewModel: FavoritesViewModelProtocol) {
        self.favoritesView = favoritesView
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
    
    private func setupFavoritesView() {
        favoritesView.setupTableViewProtocols(delegate: self,
                                              dataSource: self)
        view = favoritesView
    }
    
    private func populateView() {
        viewModel.loadFavoritedUsersFromCoreData()
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
extension FavoritesVC: UITableViewDataSource {
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
extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(indexPath: indexPath)
    }
}
// MARK: - UserTableViewCellDelegate
extension FavoritesVC: UserTableViewCellDelegate {
    func addFavoriteTapped(user: UserProfile, indexPath: IndexPath) {}
    func removeFavoriteTapped(user: UserProfile, indexPath: IndexPath) {
        viewModel.removeFavorited(at: indexPath.row)
    }
}
//MARK: FavoritesViewDelegate
extension FavoritesVC: FavoritesViewDelegate {
    func fetchContactsTableData() {
        viewModel.loadFavoritedUsersFromCoreData()
    }
}
//MARK: FavoritesViewModelDelegate
extension FavoritesVC: FavoritesViewModelDelegate {
    func updateUsersView(with state: StateView) {
        switch state {
        case .loading:
            favoritesView.startRefresh()
        case .loaded:
            favoritesView.stopRefresh()
        case .hasData:
            favoritesView.reloadTableData()
        }
    }
    
    func showError(title: String, message: String, btnTitle: String) {
        presentError(title: title,
                     message: message,
                     btnTitle: btnTitle)
    }
}
