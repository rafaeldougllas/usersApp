//
//  UserTableViewCell.swift
//  UsersApp
//
//  Created by Rafael Douglas on 17/12/22.
//

import UIKit

protocol UserTableViewCellDelegate: AnyObject {
    func addFavoriteTapped(user: UserProfile,
                           indexPath: IndexPath)
    func removeFavoriteTapped(user: UserProfile,
                              indexPath: IndexPath)
}

final class UserTableViewCell: UITableViewCell {
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private var indexPath: IndexPath?
    private var user: UserProfile?
    weak var delegate: UserTableViewCellDelegate?
    
    // MARK: - UI
    private lazy var icon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondary
        view.clipsToBounds = true
        view.layer.cornerRadius = view.frame.size.width / 2
        view.tintColor = .tertiary
        return view
    }()
    
    private lazy var nameLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .tertiary
        return view
    }()
    
    private lazy var favoriteBtn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(didTapFavoriteBtn(sender:)), for: .touchUpInside)
        view.tintColor = .quaternary
        return view
    }()
    
    // MARK: - Methods
    func setup(indexPath: IndexPath,
               delegate: UserTableViewCellDelegate,
               user: UserProfile) {
        self.indexPath = indexPath
        self.delegate = delegate
        self.user = user
        setupUI(user: user)
    }
    
    private func setupUI(user: UserProfile) {
        nameLbl.text = user.firstName
        KingfisherLoader.shared.setImage(imageView: icon,
                                         from: URL(string: user.icon),
                                         placeholderImage: UIImage(systemName: "person"),
                                         completion: { [weak self] result in
                                            guard let self = self else { return }
                                            
                                            self.setCircleLayoutToImage()
                                            switch result {
                                            case .success():
                                                self.icon.backgroundColor = .secondary
                                            case .failure(_):
                                                self.icon.backgroundColor = .secondary
                                            }
                                         })
        if let isFavorite = user.isFavorite, isFavorite {
            favoriteBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteBtn.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    
    private func setCircleLayoutToImage() {
        icon.clipsToBounds = true
        icon.layer.cornerRadius = icon.frame.size.width / 2
    }
    
    @objc private func didTapFavoriteBtn(sender: UIButton) {
        guard var user = self.user,
              let isFav = user.isFavorite,
              let indexPath = indexPath else { return }
        if isFav {
            sender.setImage(UIImage(systemName: "star"), for: .normal)
            user.isFavorite = !isFav
            delegate?.removeFavoriteTapped(user: user, indexPath: indexPath)
        } else {
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
            user.isFavorite = !isFav
            delegate?.addFavoriteTapped(user: user, indexPath: indexPath)
        }
    }
}
// MARK: ViewCodeProtocol
extension UserTableViewCell: ViewCodeProtocol {
    func buildViewHierarchy() {
        contentView.addSubview(icon)
        contentView.addSubview(nameLbl)
        contentView.addSubview(favoriteBtn)
    }
    
    func setupContraints() {
        icon.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(16)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        nameLbl.snp.makeConstraints{ make in
            make.centerY.equalTo(icon.snp.centerY)
            make.centerX.equalToSuperview()
            make.left.equalTo(icon.snp.right).offset(8)
        }
        
        favoriteBtn.snp.makeConstraints{ make in
            make.centerY.equalTo(nameLbl.snp.centerY)
            make.right.equalToSuperview().inset(16)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    func setupAdditionals() {
        selectionStyle = .none
        backgroundColor = .secondary
    }
    
    func setupAccessibility() {
        isAccessibilityElement = true
        accessibilityLabel = "accessibility.user.tableview.cell".localized()
        accessibilityIdentifier = "userCell"
    }
}
