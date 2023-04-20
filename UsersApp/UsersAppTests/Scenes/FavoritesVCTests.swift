//
//  FavoritesVCTests.swift
//  UsersAppTests
//
//  Created by Rafael Douglas Sousa Barreto Dos Santos on 15/04/23.
//

import XCTest
@testable import UsersApp

final class FavoritesVCTests: XCTestCase {
    var favoritesViewSpy: FavoritesViewSpy!
    var favoritesViewModel: FavoritesViewModelProtocol!
    var coreDataMock: CoreDataMock!
    var sut: FavoritesVC!
    
    override func setUp() {
        super.setUp()
        favoritesViewSpy = FavoritesViewSpy()
        coreDataMock = CoreDataMock()
        favoritesViewModel = FavoritesViewModel(coreData: coreDataMock)
        sut = FavoritesVC(favoritesView: favoritesViewSpy,
                          viewModel: favoritesViewModel)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_viewDidLoad_called() {
        // Given
        
        // When
        sut.viewDidLoad()
        // Then
        XCTAssertEqual(sut.title, favoritesViewModel.getPageTitle(), "Should be the same from viewModel")
        XCTAssertTrue(favoritesViewModel.numberOfRows() > 0, "Should be more than zero because after viewDidLoad called populateView function")
        XCTAssert(favoritesViewSpy.setupTableViewProtocolsCalled == false, "Should be not called")
    }
    
    func test_setupTableViewProtocols_called() {
        // Given
        _ = coreDataMock.loadUsersFavorited()
        // When
        sut.loadView()
        // Then
        XCTAssertTrue(favoritesViewSpy.setupTableViewProtocolsCalled, "Should be called")
    }

}
