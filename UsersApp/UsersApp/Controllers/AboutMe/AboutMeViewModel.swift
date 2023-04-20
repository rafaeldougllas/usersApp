//
//  AboutMeViewModel.swift
//  UsersApp
//
//  Created by Rafael Douglas on 20/12/22.
//

import Foundation

protocol AboutMeViewModelProtocol {
    var coordinator: AboutMeCoordinatorProtocol? { get set }
    
    func getPageTitle() -> String
    func getIosTools() -> [String]
    func getDescriptionText() -> String
    func getIosToolsTitleText() -> String
}

final class AboutMeViewModel: AboutMeViewModelProtocol {
    //MARK: - Properties
    weak var coordinator: AboutMeCoordinatorProtocol?
    
    private let iosToolsArr: [String] = ["Snapkit", "RxSwift", "Swinject", "Quick", "Nimble",
                                 "Alamofire", "SkeletonView", "swiftlint", "Fastlane",
                                 "Bitrise", "Carthage", "Brew"]
    private enum texts {
        static let pageTitle = "about.me.page.title".localized()
        static let descriptionAboutMe = "about.me.complete.description".localized()
        static let iosToolsTitle = "about.me.complete.ios.tools.title".localized()
    }
    
    //MARK: - Methods
    func getPageTitle() -> String {
        texts.pageTitle
    }
    
    func getIosTools() -> [String] {
        iosToolsArr
    }
    
    func getDescriptionText() -> String {
        texts.descriptionAboutMe
    }
    
    func getIosToolsTitleText() -> String {
        texts.iosToolsTitle
    }
}
