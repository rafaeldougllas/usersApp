//
//  CoreDataTests.swift
//  UsersAppTests
//
//  Created by Rafael Douglas Sousa Barreto Dos Santos on 19/04/23.
//

import XCTest
@testable import UsersApp

final class CoreDataTests: XCTestCase {
    var sut: UserCoreDataProtocol!
    
    override func setUp() {
        super.setUp()
        sut = UserCoreData.shared
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_loadUsersFavorited() {
        let favCount = sut.loadUsersFavorited()
        XCTAssertTrue(favCount.count == 0)
    }
    
    func test_addRemoveUsersFavorited() {
        sut.addFavorite(.fixture(id: 10))
        XCTAssertTrue(sut.loadUsersFavorited().count > 0)
        sut.removeFavorite(id: 10)
        XCTAssertTrue(sut.loadUsersFavorited().count == 0)
    }
}
