//
//  UsersVCTests.swift
//  UsersAppTests
//
//  Created by Rafael Douglas Sousa Barreto Dos Santos on 15/04/23.
//

import XCTest
@testable import UsersApp

final class UsersVCTests: XCTestCase {
    var usersViewSpy: UsersViewSpy!
    var usersViewModel: UsersViewModel!
    var usersUseCase: UsersUseCaseStub!
    var sut: UsersVC!
    
    override func setUp() {
        super.setUp()
        usersViewSpy = UsersViewSpy()
        usersUseCase = UsersUseCaseStub()
        usersViewModel = UsersViewModel(usersUseCase: usersUseCase)
        sut = UsersVC(usersView: usersViewSpy,
                      viewModel: usersViewModel)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_viewDidLoad_called() {
        // Given
        usersUseCase.isSuccess = true
        // When
        sut.viewDidLoad()
        // Then
        XCTAssertEqual(sut.title, usersViewModel.getPageTitle(), "Should be the same from viewModel")
        XCTAssertTrue(usersViewModel.numberOfRows() > 0, "Should be more than zero because after viewDidLoad called populateView function")
        XCTAssert(usersViewSpy.setupTableViewProtocolsCalled == false, "Should be not called")
    }
    
    func test_setupTableViewProtocols_called() {
        // Given
        usersUseCase.isSuccess = true
        // When
        sut.loadView()
        // Then
        XCTAssertTrue(usersViewSpy.setupTableViewProtocolsCalled, "Should be called")
        
    }
}
