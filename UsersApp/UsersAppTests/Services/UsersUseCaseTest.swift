//
//  UsersUseCaseTest.swift
//  UsersAppTests
//
//  Created by Rafael Douglas Sousa Barreto Dos Santos on 11/04/23.
//

import XCTest
@testable import UsersApp

final class UsersUseCaseTest: XCTestCase {

    var urlSessionMock: URLSession!
    let reqURL = URL(string: Endpoints.users.fullPath)!
    var httpClient: HttpClientProtocol!
    var sut: UsersUseCaseProtocol!
    
    override func setUp() {
        super.setUp()
        /* An ephemeral, or private, session keeps cache data, credentials or other session related data in memory. It’s never written to disk which helps protects user privacy. You destroy the session data when you invalidate the session. This is similar to how a web browser behaves when private browsing. */
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        urlSessionMock = URLSession(configuration: config)
        httpClient = HttpClient(service: urlSessionMock)
        sut = UsersUseCase(client: httpClient)
    }
    
    override func tearDown() {
        super.tearDown()
        urlSessionMock = nil
        sut = nil
    }
    
    func test_FetchUsers_Success() throws {
        let response = UsersManagerMock.mockResponse(reqURL: reqURL, isSuccess: true)
        let (data, _) = UsersManagerMock.mockData()
        
        URLProtocolMock.requestHandler = { request in
            return (response, data)
        }
        
        let expectation = XCTestExpectation(description: "Success response")
        
        sut.fetchUsers() { (result: Result<(UsersResponse, HTTPURLResponse), Error>) in
            switch result {
            case let .success((userResponse, response)):
                XCTAssertEqual(userResponse.data.first?.icon, "https://reqres.in/img/faces/1-image.jpg")
                XCTAssertEqual(userResponse.data.count, 1)
                XCTAssertEqual(response.statusCode, 200)
                
                expectation.fulfill()
            case let .failure(error):
                XCTAssertThrowsError(error)
            }
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func test_FetchUsers_Failured_BadResponse() throws {
        let response = UsersManagerMock.mockResponse(reqURL: reqURL, isSuccess: false)
        let (data, _) = UsersManagerMock.mockData()
        
        URLProtocolMock.requestHandler = { request in
            return (response, data)
        }
        
        let expectation = XCTestExpectation(description: "Failed response")
        
        sut.fetchUsers() { (result: Result<(UsersResponse, HTTPURLResponse), Error>) in
            switch result {
            case .success((_, _)):
                XCTAssertThrowsError("Fatal Error")
            case let .failure(error):
                XCTAssertEqual(HttpCustomError.badResponse, error as? HttpCustomError)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func test_FetchUsers_Failured_DecodingData() throws {
        let response = UsersManagerMock.mockResponse(reqURL: reqURL, isSuccess: true)
        let (data, _) = UsersManagerMock.mockData(wrongData: true)
        
        URLProtocolMock.requestHandler = { request in
            return (response, data)
        }
        
        let expectation = XCTestExpectation(description: "Failed Decoding Data")
        
        sut.fetchUsers() { (result: Result<(UsersResponse, HTTPURLResponse), Error>) in
            switch result {
            case .success((_, _)):
                XCTAssertThrowsError("Fatal Error")
            case let .failure(error):
                XCTAssertEqual(HttpCustomError.errorDecodingData, error as? HttpCustomError)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2)
    }
}
