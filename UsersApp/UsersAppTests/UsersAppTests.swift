//
//  UsersAppTests.swift
//  UsersAppTests
//
//  Created by Rafael Douglas on 19/11/22.
//

import XCTest
@testable import UsersApp

class UsersViewModelTests: XCTestCase {
    
    var viewModel: UsersViewModelProtocol!
    var successAPI = SuccessAPI()
    var coreDataMock = CoreDataMock()
    var errorPresented = false
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = UsersViewModel(apiManager: successAPI, coreData: coreDataMock)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testInitialization() {
        XCTAssertTrue(viewModel.APIManager === successAPI, "The API should be equal to the API tha was passed in.")
    }
    
    func testUsersCountAfterServiceCall() throws {
        viewModel.fetchUsers { _ in }
        
        XCTAssertEqual(successAPI.fetchedUsers.count, viewModel.getUsersArr().count)
    }
    
    func testUsersRowHeight() {
        XCTAssert(viewModel.heightForRow == 112)
    }
    
    func testUsersScreenTitle() {
        XCTAssertTrue(viewModel.getPageTitle() == "users.page.title".localized())
    }
    
    func testUsersEmptyRowsText() {
        XCTAssert(viewModel.getEmptyRowsText() == "users.table.empty".localized())
    }
    
    func testUsersOnIndex() {
        viewModel.fetchUsers { _ in }
        let index = 1
        guard let targetUser = viewModel.modelAt(index) else { return }
        XCTAssert(successAPI.fetchedUsers[index].id == targetUser.id)
    }
    
    func testUsersAddFavorite() {
        viewModel.addFavorited(user: .fixture(), indexPath: .init(row: 1, section: 1))
        
        XCTAssert(coreDataMock.loadedFavoriteUsers[0].id == 1)
    }
    
    func testUsersRemoveFavorite() {
        let fakeUser: UserProfile = .fixture(id: 10)
        viewModel.addFavorited(user: fakeUser, indexPath: .init(row: 1, section: 1))
        
        XCTAssertTrue(coreDataMock.loadedFavoriteUsers[0].id == fakeUser.id)
        
        viewModel.removeFavorited(user: fakeUser, indexPath: .init(row: 1, section: 1))
        
        XCTAssertTrue(coreDataMock.loadedFavoriteUsers.isEmpty)
    }
    
    func testUsersGetUsersArr() {
        viewModel.fetchUsers { _ in }
        
        XCTAssert(viewModel.getUsersArr().count == successAPI.fetchedUsers.count)
    }
    
    func testUsersSetUsersArr() {
        let targetUsers: [UserProfile] = [.fixture(id: 1), .fixture(id: 2)]
        
        viewModel.setUsersArr(users: targetUsers)
        
        XCTAssert(viewModel.getUsersArr() == targetUsers)
    }
    
    func testUsersShowErrorAlert() {
        viewModel.presentError(navigation: UINavigationController(), completion: { [weak self] in
            guard let self = self else { return }
            self.errorPresented = true
        })
        XCTAssert(errorPresented == true)
    }
}
