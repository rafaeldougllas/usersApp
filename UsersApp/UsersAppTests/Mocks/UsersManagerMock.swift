//
//  UsersManagerMock.swift
//  UsersAppTests
//
//  Created by Rafael Douglas Sousa Barreto Dos Santos on 11/04/23.
//

import XCTest
@testable import UsersApp

final class UsersManagerMock {
    static func mockData(wrongData: Bool = false) -> (data: Data, model: UserProfile) {
        let jsonOk = """
        {
            "page": 1,
            "per_page": 1,
            "total": 12,
            "total_pages": 12,
            "data": [
                  {
                    "id": 1,
                    "email": "email@gmail.com",
                    "first_name": "Fake",
                    "last_name": "Junior",
                    "avatar": "https://reqres.in/img/faces/1-image.jpg"
                  }
            ]
        }
        """
        let jsonBad = """
        {
            "xxx": 1,
            "yy": 1
        }
        """
        let data = wrongData ? jsonBad.data(using: .utf8)! : jsonOk.data(using: .utf8)!
        let model: UserProfile = .fixture()
        
        return (data, model)
    }
    
    static func mockResponse(reqURL: URL, isSuccess: Bool) -> HTTPURLResponse {
        let statusCode = isSuccess ? 200 : 400
        let response = HTTPURLResponse(url: reqURL,
                                       statusCode: statusCode,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        return response
    }
}
