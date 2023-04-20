//
//  AboutMeVCTests.swift
//  UsersAppTests
//
//  Created by Rafael Douglas Sousa Barreto Dos Santos on 16/04/23.
//

import XCTest
@testable import UsersApp

final class AboutMeVCTests: XCTestCase {
    var aboutMeViewSpy: AboutMeViewSpy!
    var aboutMeViewModel: AboutMeViewModelSpy!
    var sut: AboutMeVC!
    
    override func setUp() {
        super.setUp()
        aboutMeViewSpy = AboutMeViewSpy()
        aboutMeViewModel = AboutMeViewModelSpy()
        sut = AboutMeVC(aboutMeView: aboutMeViewSpy,
                        aboutMeViewModel: aboutMeViewModel)
    }
    
    override func tearDown() {
        super.tearDown()
        aboutMeViewSpy = nil
        aboutMeViewModel = nil
        sut = nil
    }
    
    func test_viewDidLoad_called() {
        // Given
        
        // When
        sut.viewDidLoad()
        // Then
        XCTAssertEqual(sut.title, aboutMeViewModel.getPageTitle(), "Should be the same from viewModel")
        XCTAssertTrue(aboutMeViewModel.getPageTitleCalled)
        XCTAssertTrue(aboutMeViewModel.getDescriptionTextCalled)
        XCTAssertTrue(aboutMeViewModel.getIosToolsTitleTextCalled)
        XCTAssertTrue(aboutMeViewModel.getIosToolsCalled)
    }
    
    func test_setupTableViewProtocols_called() {
        // Given
        // When
        sut.loadView()
        // Then
        XCTAssertEqual(sut.view, aboutMeViewSpy)
    }
}
