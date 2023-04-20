//
//  AboutMeViewModelTests.swift
//  UsersAppTests
//
//  Created by Rafael Douglas on 21/12/22.
//

import XCTest
@testable import UsersApp

final class AboutMeViewModelTests: XCTestCase {

    var sut: AboutMeViewModel!
    
    override func setUp() {
        super.setUp()
        sut = AboutMeViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_PageTitle() {
        // When
        let pageTitle = sut.getPageTitle()
        // Then
        XCTAssertTrue(pageTitle == "about.me.page.title".localized())
    }
    
    func test_DescriptionText() {
        // When
        let descriptionText = sut.getDescriptionText()
        // Then
        XCTAssertTrue(descriptionText == "about.me.complete.description".localized())
    }
    
    func test_IosToolsTitleText() {
        // When
        let iosToolsTitle = sut.getIosToolsTitleText()
        // Then
        XCTAssertTrue(iosToolsTitle == "about.me.complete.ios.tools.title".localized())
    }
    
    func test_GetIosToolsArr() {
        // When
        let iosTools = sut.getIosTools()
        // Then
        XCTAssert(iosTools.count > 0)
    }
}
// MARK: - AboutMeViewModelSpy
final class AboutMeViewModelSpy: AboutMeViewModelProtocol {
    var coordinator: UsersApp.AboutMeCoordinatorProtocol?
    private(set) var getPageTitleCalled = false
    private(set) var getIosToolsCalled = false
    private(set) var getDescriptionTextCalled = false
    private(set) var getIosToolsTitleTextCalled = false
    
    func getPageTitle() -> String {
        getPageTitleCalled = true
        return "about.me.page.title".localized()
    }
    
    func getIosTools() -> [String] {
        getIosToolsCalled = true
        return [""]
    }
    
    func getDescriptionText() -> String {
        getDescriptionTextCalled = true
        return "about.me.complete.description".localized()
    }
    
    func getIosToolsTitleText() -> String {
        getIosToolsTitleTextCalled = true
        return "about.me.complete.ios.tools.title".localized()
    }
}
