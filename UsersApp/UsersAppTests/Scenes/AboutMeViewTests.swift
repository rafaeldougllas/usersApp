//
//  AboutMeViewTests.swift
//  UsersAppTests
//
//  Created by Rafael Douglas Sousa Barreto Dos Santos on 16/04/23.
//

import XCTest
@testable import UsersApp

final class AboutMeViewTests: XCTestCase {
    var sut: AboutMeViewSpy!
    
    override func setUp() {
        super.setUp()
        sut = AboutMeViewSpy()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_addIosTool_called() {
        // Given
        // When
        sut.addIosTool(text: "")
        // Then
        XCTAssertTrue(sut.addIosToolCalled, "Should be true because addIosToolCalled method was called")
    }
    
    func test_setTextsInLabels_called() {
        // Given
        // When
        sut.setTextsInLabels(description: "",
                             iosToolsTitle: "")
        // Then
        XCTAssertTrue(sut.setTextsInLabelsCalled, "Should be true because setTextsInLabels method was called")
    }
}
// MARK: - AboutMeViewSpy
final class AboutMeViewSpy: UIView, AboutMeViewProtocol {
    private(set) var addIosToolCalled = false
    private(set) var setTextsInLabelsCalled = false
    
    func addIosTool(text: String) {
        addIosToolCalled = true
    }
    
    func setTextsInLabels(description: String, iosToolsTitle: String) {
        setTextsInLabelsCalled = true
    }
}
