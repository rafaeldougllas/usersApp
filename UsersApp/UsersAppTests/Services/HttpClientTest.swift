//
//  HttpClientTest.swift
//  UsersAppTests
//
//  Created by Rafael Douglas Sousa Barreto Dos Santos on 11/04/23.
//

import XCTest
@testable import UsersApp

final class HttpClientTest: XCTestCase {
    var urlSession: URLSession!
    let reqURL = URL(string: Endpoints.users.fullPath)!
    var sut: HttpClientProtocol!
    
    override func setUp() {
        super.setUp()
        /* An ephemeral, or private, session keeps cache data, credentials or other session related data in memory. It’s never written to disk which helps protects user privacy. You destroy the session data when you invalidate the session. This is similar to how a web browser behaves when private browsing. */
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        urlSession = URLSession(configuration: config)
        
        sut = HttpClient(service: urlSession)
    }
    
    override func tearDown() {
        super.tearDown()
        urlSession = nil
        sut = nil
    }
    
    func test_Fetch_Success() throws {
        let response = UsersManagerMock.mockResponse(reqURL: reqURL, isSuccess: true)
        let (data, _) = UsersManagerMock.mockData()
        
        URLProtocolMock.requestHandler = { request in
            return (response, data)
        }
        
        let expectation = XCTestExpectation(description: "Success response")
        
        sut.fetch(url: reqURL) { (result: Result<(UsersResponse, HTTPURLResponse), Error>) in
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
    
    func test_Fetch_Failured_BadResponse() throws {
        let response = UsersManagerMock.mockResponse(reqURL: reqURL, isSuccess: false)
        let (data, _) = UsersManagerMock.mockData()
        
        URLProtocolMock.requestHandler = { request in
            return (response, data)
        }
        
        let expectation = XCTestExpectation(description: "Failed response")
        
        sut.fetch(url: reqURL) { (result: Result<(UsersResponse, HTTPURLResponse), Error>) in
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
    
    func test_Fetch_Failured_DecodingData() throws {
        let response = UsersManagerMock.mockResponse(reqURL: reqURL, isSuccess: true)
        let (data, _) = UsersManagerMock.mockData()
        
        URLProtocolMock.requestHandler = { request in
            return (response, data)
        }
        
        let expectation = XCTestExpectation(description: "Failed Decoding Data")
        
        sut.fetch(url: reqURL) { (result: Result<([UserProfile], HTTPURLResponse), Error>) in
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
