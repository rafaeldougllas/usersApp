//
//  FavoritesView.swift
//  UsersApp
//
//  Created by Rafael Douglas on 18/12/22.
//

import UIKit
import SnapKit

protocol FavoritesViewDelegate: AnyObject {
    func fetchContactsTableData()
}

protocol FavoritesViewProtocol: UIView {
    var delegate: FavoritesViewDelegate? { get set }
    
    func setupTableViewProtocols(delegate: UITableViewDelegate,
                                 dataSource: UITableViewDataSource)
    func reloadTableData()
    func startRefresh()
    func stopRefresh()
}

final class FavoritesView: UIView {
    
    // MARK: - Properties
    weak var delegate: FavoritesViewDelegate?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private lazy var refreshControl: UIRefreshControl = {
        let view =  UIRefreshControl()
        view.addTarget(self, action: #selector(refreshTableData(_:)), for: .valueChanged)
        view.tintColor = .primary
        view.attributedTitle = NSAttributedString(string: "tableview.refresh.text".localized())
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondary
        view.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.className)
        view.refreshControl = refreshControl
        return view
    }()
    
    // MARK: - Methods
    @objc private func refreshTableData(_ sender: Any) {
        delegate?.fetchContactsTableData()
    }
}

// MARK: - ViewCode
extension FavoritesView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupContraints() {
        tableView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
         }
    }
    
    func setupAccessibility() {
        tableView.isAccessibilityElement = true
        tableView.accessibilityLabel = "accessibility.favorited.users.tableview".localized()
        tableView.accessibilityIdentifier = "usersFavoritedList"
    }
}
// MARK: - FavoritesViewProtocol
extension FavoritesView: FavoritesViewProtocol {
    func setupTableViewProtocols(delegate: UITableViewDelegate,
                                 dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    func reloadTableData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.tableView.reloadData()
            self.stopRefresh()
        }
    }
    
    func startRefresh() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            refreshControl.beginRefreshing()
        }
    }
    
    func stopRefresh() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            refreshControl.endRefreshing()
        }
    }
}
