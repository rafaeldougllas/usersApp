//
//  HttpCustomError.swift
//  UsersApp
//
//  Created by Rafael Douglas Sousa Barreto Dos Santos on 07/04/23.
//

import Foundation

enum HttpCustomError: Error {
    case badResponse, errorDecodingData, invalidURL, noConnectivity
}
