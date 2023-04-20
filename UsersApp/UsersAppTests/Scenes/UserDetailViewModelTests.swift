//
//  UserDetailViewModelTests.swift
//  UsersAppTests
//
//  Created by Rafael Douglas on 18/12/22.
//

import XCTest
@testable import UsersApp

final class UserDetailViewModelTests: XCTestCase {

    var sut: UserDetailViewModelProtocol!
    var user: UserProfile!
    
    override func setUp() {
        super.setUp()
        user = .fixture()
        sut = UserDetailViewModel(user: user)
    }
    
    override func tearDown() {
        super.tearDown()
        user = nil
        sut = nil
    }
    
    func test_Initialization() {
        XCTAssertTrue(sut.getUser() == user)
    }
    
    func test_UserDetailScreenTitle() {
        XCTAssertTrue(sut.getPageTitle() == "userDetail.page.title".localized())
    }
}
