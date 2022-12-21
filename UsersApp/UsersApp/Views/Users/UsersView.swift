//
//  UsersView.swift
//  UsersApp
//
//  Created by Rafael Douglas on 17/12/22.
//

import UIKit
import SnapKit

protocol UsersViewDelegate: AnyObject {
    func showRefreshControl()
}

class UsersView: UIView {
    
    // MARK: - Properties
    weak var delegate: UsersViewDelegate?
    
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
    public func setupTableViewProtocols(delegate: UITableViewDelegate,
                                        dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    public func reloadTable() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @objc public func refreshTableData(_ sender: Any) {
        delegate?.showRefreshControl()
    }
}
// MARK: - ViewCode
extension UsersView: ViewCodeProtocol {
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
        tableView.accessibilityLabel = "accessibility.users.tableview".localized()
        tableView.accessibilityIdentifier = "usersList"
    }
}
