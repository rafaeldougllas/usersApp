//
//  UserDetailView.swift
//  UsersApp
//
//  Created by Rafael Douglas on 18/12/22.
//

import SnapKit
import UIKit

protocol UserDetailViewProtocol: UIView {
    func populateView(user: UserProfile)
}

final class UserDetailView: UIView {
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private lazy var titleLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldSystemFont(ofSize: 22)
        view.text = "Contact me"
        view.tintColor = .tertiary
        view.textAlignment = .center
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameLbl, emailLbl, profileImg])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 16
        view.distribution = .fill
        view.alignment = .center
        return view
    }()
    
    private lazy var nameLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .tertiary
        return view
    }()
    
    private lazy var emailLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .tertiary
        return view
    }()
    
    private lazy var profileImg: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondary
        return view
    }()
}
// MARK: - ViewCode
extension UserDetailView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(titleLbl)
        addSubview(stackView)
    }
    
    func setupContraints() {
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(32)
            make.left.equalTo(titleLbl.snp.left)
            make.right.equalTo(titleLbl.snp.right)
        }
    }
    
    func setupAdditionals() {
        backgroundColor = .secondary
    }
    
    func setupAccessibility() {
        titleLbl.isAccessibilityElement = true
        titleLbl.accessibilityLabel = "accessibility.user.detail.title".localized()
        titleLbl.accessibilityIdentifier = "userDetailTitle"
        
        profileImg.isAccessibilityElement = true
        profileImg.accessibilityLabel = "accessibility.user.detail.profile.image".localized()
        profileImg.accessibilityIdentifier = "userDetailProfileImage"
        profileImg.accessibilityTraits = .image
        
        nameLbl.isAccessibilityElement = true
        nameLbl.accessibilityLabel = "accessibility.user.detail.name".localized()
        nameLbl.accessibilityIdentifier = "userDetailName"
        
        emailLbl.isAccessibilityElement = true
        emailLbl.accessibilityLabel = "accessibility.user.detail.email".localized()
        emailLbl.accessibilityIdentifier = "userDetailEmail"
    }
}
// MARK: - UserDetailViewProtocol
extension UserDetailView: UserDetailViewProtocol {
    func populateView(user: UserProfile) {
        let fullname = "\(user.lastName), \(user.firstName)"
        nameLbl.attributedText = fullname.getBoldAttributedString(boldString: user.lastName)
        emailLbl.text = user.email
        
        KingfisherLoader.shared.setImage(imageView: profileImg,
                                         from: URL(string: user.icon),
                                         placeholderImage: UIImage(systemName: "person"),
                                         completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success():
                self.profileImg.backgroundColor = .secondary
            case .failure(_):
                self.profileImg.backgroundColor = .secondary
            }
        })
    }
}
