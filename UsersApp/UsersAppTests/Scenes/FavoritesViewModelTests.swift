//
//  FavoritesViewModelTests.swift
//  UsersAppTests
//
//  Created by Rafael Douglas on 18/12/22.
//

import XCTest
@testable import UsersApp

final class FavoritesViewModelTests: XCTestCase {
    
    var sut: FavoritesViewModelProtocol!
    var coreDataMock: CoreDataMock!

    override func setUp() {
        super.setUp()
        coreDataMock = CoreDataMock()
        sut = FavoritesViewModel(coreData: coreDataMock)
    }

    override func tearDown() {
        super.tearDown()
        coreDataMock = nil
        sut = nil
    }
    
    func test_FavoritesRowHeight() {
        XCTAssert(sut.getHeightForRow() == 112)
    }
    
    func test_FavoritesScreenTitle() {
        XCTAssertTrue(sut.getPageTitle() == "favorites.page.title".localized())
    }
    
    func test_FavoritesEmptyRowsText() {
        XCTAssert(sut.getEmptyRowsText() == "favorites.table.empty".localized())
    }
    
    func test_NumberOfRows() {
        sut.loadFavoritedUsersFromCoreData()

        XCTAssert(sut.numberOfRows() == 5)
    }
    
    func test_ModelAt() {
        sut.loadFavoritedUsersFromCoreData()
        
        let index = 1
        guard let targetUser = sut.modelAt(index) else { return }
        
        XCTAssert(targetUser.id == 2)
    }
    
    func test_DidSelect() {
        let coordinatorSpy = FavoritesCoordinatorSpy()
        sut.coordinator = coordinatorSpy
        
        sut.loadFavoritedUsersFromCoreData()
        sut.didSelect(indexPath: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(coordinatorSpy.moveToCalled)
    }
    
    func test_FavoritesCountAfterCoreDataCall() {
        sut.loadFavoritedUsersFromCoreData()

        XCTAssertEqual(coreDataMock.loadedFavoriteUsers.count, 5)
    }

    func testFavoritesRemoveFavorited() {
        sut.loadFavoritedUsersFromCoreData()

        sut.removeFavorited(at: 0)

        XCTAssertTrue(coreDataMock.loadedFavoriteUsers.count == 4)
    }
}

final class FavoritesCoordinatorSpy: FavoritesCoordinatorProtocol {
    var rootViewController: UIViewController = UIViewController()
    private(set) var moveToCalled = false
    
    func start() -> UIViewController {
        return rootViewController
    }
    
    func moveTo(flow: UsersApp.AppFlow, userData: [String : Any]?) {
        moveToCalled = true
    }
    
    var parentCoordinator: UsersApp.MainCoordinatorProtocol?
}
