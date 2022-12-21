//
//  UserDetailViewModelTests.swift
//  UsersAppTests
//
//  Created by Rafael Douglas on 18/12/22.
//

import XCTest
@testable import UsersApp

class UserDetailViewModelTests: XCTestCase {

    var viewModel: UserDetailViewModel!
    var user: UserProfile!
    let userDetailView = UserDetailView()
    var viewPopulated = false
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        user = .fixture()
        viewModel = UserDetailViewModel(user: user)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        user = nil
    }
    
    func testInitialization() {
        XCTAssertTrue(viewModel.user == user)
    }
    
    func testUserDetailScreenTitle() {
        XCTAssertTrue(viewModel.getPageTitle() == "userDetail.page.title".localized())
    }
    
    func testPopulateView() {
        viewModel.populateView(view: userDetailView, completion: { [weak self] in
            guard let self = self else { return }
            self.viewPopulated = true
        })
        XCTAssertTrue(viewPopulated)
    }
}
