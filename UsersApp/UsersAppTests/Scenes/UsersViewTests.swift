//
//  UsersViewTests.swift
//  UsersAppTests
//
//  Created by Rafael Douglas Sousa Barreto Dos Santos on 15/04/23.
//

import XCTest
@testable import UsersApp

final class UsersViewTests: XCTestCase {
    var sut: UsersViewSpy!
    
    override func setUp() {
        super.setUp()
        sut = UsersViewSpy()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_setupTableViewProtocols_called() {
        // Given
        let tableViewDelegate: UITableViewDelegate = self
        let tableViewDataSource: UITableViewDataSource = self
        // When
        sut.setupTableViewProtocols(delegate: tableViewDelegate,
                                    dataSource: tableViewDataSource)
        // Then
        XCTAssertTrue(sut.setupTableViewProtocolsCalled, "Should be true because setup method was called")
    }
    
    func test_reloadTableData_called() {
        // When
        sut.reloadTableData()
        // Then
        XCTAssertTrue(sut.reloadTableDataCalled, "Should be true because reload method was called")
    }
    
    func test_startRefresh_called() {
        // When
        sut.startRefresh()
        // Then
        XCTAssertTrue(sut.startRefreshCalled, "Should be true because startRefresh method was called")
    }
    
    func test_stopRefresh_called() {
        // When
        sut.stopRefresh()
        // Then
        XCTAssertTrue(sut.stopRefreshCalled, "Should be true because stopRefresh method was called")
    }
}
// MARK: - UsersViewSpy
final class UsersViewSpy: UIView, UsersViewProtocol {
    var delegate: UsersApp.UsersViewDelegate?
    private(set) var setupTableViewProtocolsCalled = false
    private(set) var reloadTableDataCalled = false
    private(set) var startRefreshCalled = false
    private(set) var stopRefreshCalled = false
    
    func setupTableViewProtocols(delegate: UITableViewDelegate,
                                 dataSource: UITableViewDataSource) {
        setupTableViewProtocolsCalled = true
    }
    
    func reloadTableData() {
        reloadTableDataCalled = true
    }
    
    func startRefresh() {
        startRefreshCalled = true
    }
    
    func stopRefresh() {
        stopRefreshCalled = true
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate
extension UsersViewTests: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
