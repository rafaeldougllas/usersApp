//
//  AboutMeViewModelTests.swift
//  UsersAppTests
//
//  Created by Rafael Douglas on 21/12/22.
//

import XCTest
@testable import UsersApp

class AboutMeViewModelTests: XCTestCase {

    var viewModel: AboutMeViewModel!
    var viewPopulated = true
    let aboutMeView = AboutMeView()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = AboutMeViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testScreenTitle() {
        XCTAssertTrue(viewModel.getPageTitle() == "about.me.page.title".localized())
    }
    
    func testPopulateView() {
        viewModel.populateView(view: aboutMeView, completion: { [weak self] in
            guard let self = self else { return }
            self.viewPopulated = true
        })
        XCTAssertTrue(viewPopulated)
    }
}
