//
//  APIService.swift
//  ProductLists
//
//  Created by Priyanka Vibhute on 22/04/23.
//

import Foundation

final class APIService {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func request<T: Codable>(url: URL,
                             type: T.Type,
                             completion: @escaping (Result<T, NetworkError>) -> Void) {
        //We can use dataTask with request. As this assignments has only get URL calls, using dataTask with url.
        urlSession.dataTask(with: url) { data, response, error in
            guard let data = data else {
                if let _ = error {
                    completion(.failure(.apiError))
                } else {
                    completion(.failure(.apiError))
                }
                return
            }
            do {
                let response = try JSONDecoder().decode(type, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.apiError))
            }
            
        }.resume()
    }
}
