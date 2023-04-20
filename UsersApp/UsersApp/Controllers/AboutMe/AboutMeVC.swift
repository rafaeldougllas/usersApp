//
//  AboutMeVC.swift
//  UsersApp
//
//  Created by Rafael Douglas on 19/12/22.
//

import UIKit

final class AboutMeVC: UIViewController {
    
    // MARK: - Properties
    let aboutMeViewModel: AboutMeViewModelProtocol
    let aboutMeView: AboutMeViewProtocol

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupVC()
        populateView()
    }
    
    override func loadView() {
        super.loadView()
        setupAboutMeView()
    }
    
    // MARK: - Initializers
    init(aboutMeView: AboutMeViewProtocol,
         aboutMeViewModel: AboutMeViewModelProtocol) {
        self.aboutMeView = aboutMeView
        self.aboutMeViewModel = aboutMeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupVC() {
        title = aboutMeViewModel.getPageTitle()
    }
    
    private func setupAboutMeView() {
        view = aboutMeView
    }
    
    private func populateView() {
        aboutMeView.setTextsInLabels(description: aboutMeViewModel.getDescriptionText(),
                                     iosToolsTitle: aboutMeViewModel.getIosToolsTitleText())
        
        aboutMeViewModel.getIosTools().forEach { aboutMeView.addIosTool(text: $0) }
    }
}
