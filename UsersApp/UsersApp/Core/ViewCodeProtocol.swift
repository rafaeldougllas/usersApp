//
//  ViewCodeProtocol.swift
//  UsersApp
//
//  Created by Rafael Douglas on 17/12/22.
//

protocol ViewCodeProtocol {
    func buildViewHierarchy()
    func setupContraints()
    func setupAdditionals()
    func setupAccessibility()
    func setupView()
}

extension ViewCodeProtocol {
    func setupView() {
        buildViewHierarchy()
        setupContraints()
        setupAdditionals()
        setupAccessibility()
    }
    
    func setupAdditionals() {}
}
