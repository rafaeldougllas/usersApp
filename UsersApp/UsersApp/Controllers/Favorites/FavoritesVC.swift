//
//  FavoritesVC.swift
//  UsersApp
//
//  Created by Rafael Douglas on 18/12/22.
//

import UIKit

class FavoritesVC: UIViewController, FavoritesBaseCoordinated {
    
    // MARK: - Properties
    let viewModel: FavoritesViewModelProtocol
    let favoritesView = FavoritesView()
    var coordinator: FavoritesBaseCoordinator?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        populateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesView.delegate = self
        populateView()
    }
    
    // MARK: - Initializers
    init(viewModel: FavoritesViewModelProtocol,
         coordinator: FavoritesBaseCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupVC() {
        view = favoritesView
        title = viewModel.getPageTitle()
    }
    
    private func populateView() {
        viewModel.setupTableViewProtocols(view: self.favoritesView,
                                          delegate: self,
                                          dataSource: self)
        viewModel.loadFavoritedUsersFromCoreData(completion: { [weak self] in
            guard let self = self else { return }
            self.viewModel.reloadData(view: self.favoritesView)
        })
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
        return viewModel.heightForRow
    }
}
// MARK: - UITableViewDelegate
extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = viewModel.modelAt(indexPath.row) else { return }
        coordinator?.moveTo(flow: .favorites(.detail), userData: ["user": user])
    }
}
// MARK: - UserTableViewCellDelegate
extension FavoritesVC: UserTableViewCellDelegate {
    func addFavoriteTapped(user: UserProfile, indexPath: IndexPath) {}
    func removeFavoriteTapped(user: UserProfile, indexPath: IndexPath) {
        viewModel.removeFavorited(at: indexPath.row, completion: { [weak self] in
            guard let self = self else { return }
            self.viewModel.reloadData(view: self.favoritesView)
        })
    }
}
//MARK: UsersViewDelegate
extension FavoritesVC: FavoritesViewDelegate {
    func showRefreshControl() {
        viewModel.loadFavoritedUsersFromCoreData(completion: { [weak self] in
            guard let self = self else { return }
            self.viewModel.reloadData(view: self.favoritesView)
        })
    }
}
