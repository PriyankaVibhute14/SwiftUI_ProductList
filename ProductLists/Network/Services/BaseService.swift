//
//  BaseService.swift
//  ProductLists
//
//  Created by Priyanka Vibhute on 22/04/23.
//

import Foundation

enum AppServices {
    case productList
    case favouriteProductList
}

extension AppServices {
    var path: String {
        switch self {
        case .productList:
            return "/2f06b453-8375-43cf-861a-06e95a951328"
        case .favouriteProductList:
            return ""
        }
    }
    
    // We can add more request data here.
}

class BaseService {
    let baseURL = "https://run.mocky.io/v3"
    
    let urlSession: URLSession
    let apiService: APIService
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
        apiService = APIService()
    }
}
