//
//  UsersAppTests.swift
//  UsersAppTests
//
//  Created by Rafael Douglas on 17/12/22.
//

import XCTest
@testable import UsersApp

final class UsersViewModelTests: XCTestCase {
    
    var sut: UsersViewModelProtocol!
    var coreDataMock: CoreDataMock!
    var delegateSpy: UsersViewModelDelegateSpy!
    var usersUseCaseStub: UsersUseCaseStub!
    
    override func setUp() {
        super.setUp()
        delegateSpy = UsersViewModelDelegateSpy()
        usersUseCaseStub = UsersUseCaseStub()
        coreDataMock = CoreDataMock()
        sut = UsersViewModel(usersUseCase: usersUseCaseStub,
                             coreData: coreDataMock)
    }
    
    override func tearDown() {
        super.tearDown()
        delegateSpy = nil
        usersUseCaseStub = nil
        coreDataMock = nil
        sut = nil
    }
    
    func test_FetchUsersSuccess_IncreaseNumberOfRows() throws {
        usersUseCaseStub.isSuccess = true
        
        sut.fetchUsers()
        
        XCTAssertTrue(sut.numberOfRows() > 0)
    }
    
    func test_FetchUsersSuccess_CallDelegateActions() throws {
        usersUseCaseStub.isSuccess = true
        sut.delegate = delegateSpy
        
        sut.fetchUsers()
        
        XCTAssertTrue(delegateSpy.statesPassed[0] == StateView.loading)
        XCTAssertTrue(delegateSpy.statesPassed[1] == StateView.loaded)
        XCTAssertTrue(delegateSpy.statesPassed[2] == StateView.hasData)
        XCTAssertFalse(delegateSpy.showErrorCalled)
    }
    
    func test_FetchUsersFailured_NumberOfRows() throws {
        usersUseCaseStub.isSuccess = false
        
        sut.fetchUsers()
        
        XCTAssertTrue(sut.numberOfRows() == 0)
    }
    
    func test_FetchUsersFailured_CallDelegateActions() throws {
        usersUseCaseStub.isSuccess = false
        sut.delegate = delegateSpy
        
        sut.fetchUsers()
        
        XCTAssertTrue(delegateSpy.showErrorCalled)
    }
    
    func test_GetUsersRowHeight() {
        XCTAssert(sut.getHeightForRow() == 112)
    }
    
    func test_GetUsersScreenTitle() {
        XCTAssertTrue(sut.getPageTitle() == "users.page.title".localized())
    }
    
    func test_GetUsersEmptyRowsText() {
        XCTAssert(sut.getEmptyRowsText() == "users.table.empty".localized())
    }
    
    func test_GetUsersOnIndex() {
        usersUseCaseStub.isSuccess = true
        
        sut.fetchUsers()
        let index = 1
        guard let targetUser = sut.modelAt(index) else { return }
        
        XCTAssert(sut.getUsersArr()[index].id == targetUser.id)
    }
    
    func test_GetUsersOnInvalidIndex() {
        usersUseCaseStub.isSuccess = true
        
        sut.fetchUsers()
        
        XCTAssertNil(sut.modelAt(-1))
    }
    
    func test_AddFavoriteAtCoreData() {
        sut.addFavorited(user: .fixture(), indexPath: .init(row: 1, section: 1))

        XCTAssert(coreDataMock.loadedFavoriteUsers[0].id == 1)
    }
    
    func test_RemoveFavoriteAtCoreData() {
        let fakeUser: UserProfile = .fixture(id: 10)
        sut.addFavorited(user: fakeUser, indexPath: .init(row: 1, section: 1))
        
        XCTAssertTrue(coreDataMock.loadedFavoriteUsers[0].id == fakeUser.id)
        
        sut.removeFavorited(user: fakeUser, indexPath: .init(row: 1, section: 1))
        
        XCTAssertTrue(coreDataMock.loadedFavoriteUsers.isEmpty)
    }
}

final class UsersViewModelDelegateSpy: UsersViewModelDelegate {
    private(set) var showErrorCalled = false
    private(set) var statesPassed = [UsersApp.StateView]()
    
    func updateUsersView(with state: UsersApp.StateView) {
        statesPassed.append(state)
    }
    
    func showError(title: String, message: String, btnTitle: String) {
        showErrorCalled = true
    }
}
