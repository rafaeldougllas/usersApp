//
//  AboutMeViewModel.swift
//  UsersApp
//
//  Created by Rafael Douglas on 20/12/22.
//

import UIKit

protocol AboutMeViewModelProtocol {
    func getPageTitle() -> String
    func populateView(view: AboutMeView, completion: () -> ())
}

class AboutMeViewModel: AboutMeViewModelProtocol {
    //MARK: - Properties
    private let iosToolsArr: [String] = ["Snapkit", "RxSwift", "Swinject", "Quick", "Nimble",
                                         "Alamofire", "SkeletonView", "swiftlint", "Fastlane",
                                         "Bitrise", "Carthage", "Brew"]
    public enum texts {
        static let pageTitle = "about.me.page.title".localized()
        static let descriptionAboutMe = "about.me.complete.description".localized()
        static let iosToolsTitle = "about.me.complete.ios.tools.title".localized()
    }
    
    //MARK: - Initialization
    
    
    //MARK: - Methods
    public func getPageTitle() -> String {
        return texts.pageTitle
    }
    
    public func populateView(view: AboutMeView, completion: () -> ()) {
        view.descriptionText = texts.descriptionAboutMe
        view.iosToolsTitleText = texts.iosToolsTitle
        
        iosToolsArr.forEach { view.addIosTool(text: $0) }
        completion()
    }
}
