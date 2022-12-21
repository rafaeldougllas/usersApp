//
//  AboutMeView.swift
//  UsersApp
//
//  Created by Rafael Douglas on 19/12/22.
//

import SnapKit
import UIKit

class AboutMeView: UIView {
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private lazy var scroll: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var profileImg: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondary
        view.image = UIImage(named: "profileImage")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var descriptionLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .tertiary
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var iosToolsTitleLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .tertiary
        view.numberOfLines = 0
        view.font = .boldSystemFont(ofSize: 17)
        return view
    }()
    
    private lazy var iosToolsStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fill
        view.alignment = .center
        view.axis = .vertical
        view.spacing = 4
        return view
    }()
    
    // MARK: - Methods
    public func addIosTool(text: String) {
        iosToolsStackView.addArrangedSubview(ChipView(text: text))
    }
    
    // MARK: - Properties
    public var descriptionText: String? {
        didSet {
            descriptionLbl.text = descriptionText
        }
    }
    
    public var iosToolsTitleText: String? {
        didSet {
            iosToolsTitleLbl.text = iosToolsTitleText
        }
    }
}

extension AboutMeView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(scroll)
        scroll.addSubview(contentView)
        contentView.addSubview(profileImg)
        contentView.addSubview(descriptionLbl)
        contentView.addSubview(iosToolsTitleLbl)
        contentView.addSubview(iosToolsStackView)
    }
    
    func setupContraints() {
        scroll.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
            $0.width.equalTo(scroll.snp.width)
        }
        
        profileImg.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.right.equalToSuperview()
            make.height.equalTo(400)
        }
        
        descriptionLbl.snp.makeConstraints { make in
            make.top.equalTo(profileImg.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
        }
        
        iosToolsTitleLbl.snp.makeConstraints { make in
            make.top.equalTo(descriptionLbl.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        iosToolsStackView.snp.makeConstraints { make in
            make.top.equalTo(iosToolsTitleLbl.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalTo(contentView.snp.bottom).inset(8)
        }
    }
    
    func setupAdditionals() {
        backgroundColor = .secondary
    }
    
    func setupAccessibility() {
        profileImg.isAccessibilityElement = true
        profileImg.accessibilityLabel = "accessibility.about.me.profile".localized()
        profileImg.accessibilityIdentifier = "developerProfile"
        profileImg.accessibilityTraits = .image
        
        descriptionLbl.isAccessibilityElement = true
        descriptionLbl.accessibilityLabel = "accessibility.about.me.description".localized()
        descriptionLbl.accessibilityIdentifier = "aboutMeDescription"
        
        iosToolsTitleLbl.isAccessibilityElement = true
        iosToolsTitleLbl.accessibilityLabel = "accessibility.about.me.ios.tools.title".localized()
        iosToolsTitleLbl.accessibilityIdentifier = "iosToolsTitle"
        
        iosToolsStackView.isAccessibilityElement = true
        iosToolsStackView.accessibilityLabel = "accessibility.about.me.ios.tools".localized()
        iosToolsStackView.accessibilityIdentifier = "iosToolsList"
    }
}
