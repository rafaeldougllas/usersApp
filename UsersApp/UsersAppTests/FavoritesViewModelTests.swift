//
//  FavoritesViewModelTests.swift
//  UsersAppTests
//
//  Created by Rafael Douglas on 18/12/22.
//

import XCTest
@testable import UsersApp

class FavoritesViewModelTests: XCTestCase {
    
    var viewModel: FavoritesViewModelProtocol!
    var coreDataMock = CoreDataMock()

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = FavoritesViewModel(coreData: coreDataMock)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testInitialization() {
        XCTAssertTrue(viewModel.coreData === coreDataMock, "The CoreData should be equal to the CoreData instance that was passed in.")
    }
    
    func testFavoritesUsersCountAfterCoreDataCall() throws {
        viewModel.loadFavoritedUsersFromCoreData(completion: {})
        
        XCTAssertEqual(coreDataMock.favoriteUsers.count, viewModel.favoriteUsers.count)
    }
    
    func testUsersRowHeight() {
        XCTAssert(viewModel.heightForRow == 112)
    }
    
    func testFavoritesScreenTitle() {
        XCTAssertTrue(viewModel.getPageTitle() == "favorites.page.title".localized())
    }
    
    func testFavoritesEmptyRowsText() {
        XCTAssert(viewModel.getEmptyRowsText() == "favorites.table.empty".localized())
    }
    
    func testFavoritesOnIndex() {
        viewModel.loadFavoritedUsersFromCoreData(completion: {})
        let index = 1
        guard let targetUser = viewModel.modelAt(index) else { return }
        XCTAssert(coreDataMock.favoriteUsers[index].id == targetUser.id)
    }
    
    func testFavoritesRemoveFavorited() {
        
        viewModel.loadFavoritedUsersFromCoreData(completion: { [weak self] in
            guard let self = self else { return }
            self.coreDataMock.addFavorite(.fixture(id: 10))
        })
        
        XCTAssertFalse(coreDataMock.loadedFavoriteUsers.isEmpty)
        
        viewModel.removeFavorited(at: 0) { [weak self] in
            guard let self = self else { return }
            self.coreDataMock.removeFavorite(id: 10)
        }
        
        XCTAssertTrue(coreDataMock.loadedFavoriteUsers.isEmpty)
    }
    
    func testFavoritesCount() {
        viewModel.loadFavoritedUsersFromCoreData(completion: { [weak self] in
            guard let self = self else { return }
            self.viewModel.favoriteUsers = [.fixture(id: 1), .fixture(id: 2)]
        })
        
        XCTAssert(viewModel.numberOfRows() == 2)
    }
}
