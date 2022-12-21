//
//  APIManager.swift
//  UsersApp
//
//  Created by Rafael Douglas on 18/12/22.
//

import Alamofire
import UIKit

class APIManager: APIProtocols {
    
    func fetchUsers(completion: @escaping (Result<[UserProfile], Error>) -> Void) {
        
        AF.request(Endpoints.users.url, method: .get).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                if let userResponse = response.data,
                   let user = try? JSONDecoder().decode(UsersResponse.self, from: userResponse).data {
                    completion(.success(user))
                } else {
                    completion(.failure(NSError()))
                }
            case .failure(_):
                completion(.failure(NSError()))
            }
        })
    }
}
