//
//  DownloadImageService.swift
//  ProductLists
//
//  Created by Priyanka Vibhute on 23/04/23.
//

import Foundation
import UIKit

protocol DownloadImageServiceProtocol {
    func getImage(url: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void)
}

class DownloadImageService: BaseService, DownloadImageServiceProtocol {
    func getImage(url: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.apiError))
            return
        }
        
        ///get Image from Cache if exist
        if let image = CacheManager.shared.get(name: url.absoluteString) {
            completion(.success(image))
            return
        }
        
        urlSession?.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.apiError))
                return
            }
            if let image = UIImage(data: data) {
                
                ///Store Image In Cache
                
                CacheManager.shared.add(image: image, name: url.absoluteString)
                completion(.success(image))
            } else {
                completion(.failure(.apiError))
            }
        }.resume()
    }
}
