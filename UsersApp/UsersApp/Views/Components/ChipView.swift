//
//  ChipView.swift
//  UsersApp
//
//  Created by Rafael Douglas on 20/12/22.
//

import UIKit

class ChipView: UIView {
    
    // MARK: - Initializers
    public init(text: String) {
        super.init(frame: .zero)
        setupView()
        textLbl.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private lazy var textLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .secondary
        return view
    }()
    
    // MARK: - Properties
    public var text: String? {
        didSet {
            textLbl.text = text
        }
    }
}
// MARK: - ViewCode
extension ChipView: ViewCodeProtocol {
    func buildViewHierarchy() {
        addSubview(textLbl)
    }
    
    func setupContraints() {
        textLbl.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(4)
            $0.right.bottom.equalToSuperview().inset(4)
        }
    }
    
    func setupAdditionals() {
        backgroundColor = .primary
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
    func setupAccessibility() {
        isAccessibilityElement = true
        accessibilityLabel = "accessibility.view.chip".localized()
        accessibilityIdentifier = "iosToolsView"
    }
}
