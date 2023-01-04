//
//  AboutMeVC.swift
//  UsersApp
//
//  Created by Rafael Douglas on 19/12/22.
//

import UIKit

class AboutMeVC: UIViewController, AboutMeBaseCoordinated {
    
    // MARK: - Properties
    let viewModel: AboutMeViewModelProtocol
    let aboutMeView = AboutMeView()
    var coordinator: AboutMeBaseCoordinator?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupVC()
        populateView()
    }
    
    // MARK: - Initializers
    init(viewModel: AboutMeViewModelProtocol, coordinator: AboutMeBaseCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupVC() {
        view = aboutMeView
        title = viewModel.getPageTitle()
    }
    
    private func populateView() {
        viewModel.populateView(view: aboutMeView, completion: {})
    }
}
