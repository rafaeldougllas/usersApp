//
//  MainCoordinatorTests.swift
//  UsersAppTests
//
//  Created by Rafael Douglas Sousa Barreto Dos Santos on 19/04/23.
//

import XCTest
@testable import UsersApp

final class MainCoordinatorTests: XCTestCase {
    var sut: MainCoordinatorProtocol!
    
    override func setUp() {
        super.setUp()
        sut = CoordinatorFactory.makeMainCoordinator()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_start() {
        // Given
        // When
        let vc = sut.start()
        // Then
        XCTAssertNotNil(vc, "Should be a viewControllerl")
    }
    
    func test_moveTo() {
        // Given
        _ = sut.start()
        // When
        sut.moveTo(flow: .users(.detail), userData: nil)
        // Then
        XCTAssertNotNil(sut.rootViewController.isKind(of: UserDetailVC.self), "Should be a UserDetailVC")
    }
    
    func test_resetToRoot_called() {
        // Given
        _ = sut.start()
        // When
        sut.moveTo(flow: .users(.detail), userData: nil)
        sut.resetToRoot(animated: false)
        // Then
        XCTAssertNotNil(sut.rootViewController.isKind(of: UsersVC.self), "Should be a UsersVC")
    }
    
    func test_handleDeeplink() {
        // Given
        _ = sut.start()
        let targetLinkOption = DeepLinkOptions.aboutMe.rawValue
        // When
        sut.handleDeepLink(text: targetLinkOption, params: nil)
        // Then
        XCTAssertTrue((sut.rootViewController as? UITabBarController)?.selectedIndex == 2)
    }
}
