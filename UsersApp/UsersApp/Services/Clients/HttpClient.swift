//
//  HttpClient.swift
//  UsersApp
//
//  Created by Rafael Douglas Sousa Barreto Dos Santos on 06/04/23.
//

import Foundation

protocol HttpClientProtocol {
    typealias completion<T: Decodable> = ((Result<(T, HTTPURLResponse), Error>) -> Void)
    func fetch<T: Decodable>(url: URL, completion: @escaping completion<T>)
}

final class HttpClient {
    let service: URLSession
    
    init(service: URLSession = URLSession.shared) {
        self.service = service
    }
}
// MARK: HttpClientProtocol
extension HttpClient: HttpClientProtocol {
    func fetch<T: Decodable>(url: URL, completion: @escaping completion<T>) {
        let dataTask = service.dataTask(with: url) { data, response, error in
            
            guard error == nil else { return completion(.failure(HttpCustomError.noConnectivity)) }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                return completion(.failure(HttpCustomError.badResponse))
            }
            
            guard let data = data,
                  let dataParsed = try? JSONDecoder().decode(T.self, from: data) else {
                return completion(.failure(HttpCustomError.errorDecodingData))
            }
            
            let successBody = (dataParsed, httpResponse)
            completion(.success(successBody))
        }
        
        dataTask.resume()
    }
}
