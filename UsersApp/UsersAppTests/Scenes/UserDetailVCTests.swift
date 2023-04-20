//
//  UserDetailVCTests.swift
//  UsersAppTests
//
//  Created by Rafael Douglas Sousa Barreto Dos Santos on 17/04/23.
//

import XCTest
@testable import UsersApp

final class UserDetailVCTests: XCTestCase {
    var user: UserProfile!
    var userDetailView: UserDetailViewProtocol!
    var userDetailViewModel: UserDetailViewModelSpy!
    var sut: UserDetailVC!
    
    override func setUp() {
        super.setUp()
        user = .fixture(id: 20)
        userDetailView = UserDetailView()
        userDetailViewModel = UserDetailViewModelSpy(user: user)
        sut = UserDetailVC(userDetailView: userDetailView,
                           userDetailViewModel: userDetailViewModel)
    }
    
    override func tearDown() {
        super.tearDown()
        user = nil
        userDetailView = nil
        userDetailViewModel = nil
        sut = nil
    }
    
    func test_viewDidLoad_called() {
        // Given
        // When
        sut.viewDidLoad()
        // Then
        XCTAssertEqual(sut.title, userDetailViewModel.getPageTitle(), "Should be the same from viewModel")
        XCTAssertTrue(userDetailViewModel.getUserCalled, "Should be called to populateView")
        
    }
    
    func test_setupTableViewProtocols_called() {
        // Given
        // When
        sut.loadView()
        // Then
        XCTAssertEqual(sut.view, userDetailView)
        
    }
}

final class UserDetailViewModelSpy: UserDetailViewModelProtocol {
    private var user: UserProfile
    var coordinator: UsersApp.UsersCoordinatorProtocol?
    private(set) var getPageTitleCalled = false
    private(set) var getUserCalled = false
    
    init(user: UserProfile) {
        self.user = user
    }
    
    func getPageTitle() -> String {
        getPageTitleCalled = true
        return ""
    }
    
    func getUser() -> UsersApp.UserProfile {
        getUserCalled = true
        return .fixture()
    }
}
