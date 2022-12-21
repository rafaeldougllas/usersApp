//
//  KingfisherLoader.swift
//  UsersApp
//
//  Created by Rafael Douglas on 18/12/22.
//

import Kingfisher
import UIKit

public struct KingfisherLoader {
    private init() {}
    
    public static let shared = KingfisherLoader()
    
    public func setImage(imageView: UIImageView,
                         from url: URL?,
                         placeholderImage: UIImage?,
                         options: KingfisherOptionsInfo? = nil,
                         completion: ((Swift.Result<Void, Error>) -> Void)?) {
        imageView.kf.setImage(with: url, placeholder: placeholderImage, options: options, completionHandler: { result in
            switch result {
            case .success(_):
                completion?(.success(()))
            case .failure(let error):
                completion?(.failure(error))
            }
        })
    }
    
    public func clearMemoryCache() {
        KingfisherManager.shared.cache.clearCache()
    }
}
