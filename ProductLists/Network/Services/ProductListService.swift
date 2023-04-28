//
//  ProductListService.swift
//  ProductLists
//
//  Created by Priyanka Vibhute on 22/04/23.
//

import Foundation

protocol ProductListServiceProtocol {
    func getProductList(completion: @escaping (Result<[ProductListModel], NetworkError>) -> Void)
}

//Added this layer to keep higher level modules independent of lower level modules

class ProductListService: BaseService, ProductListServiceProtocol {
    private let appService = AppServices.productList
    func getProductList(completion: @escaping (Result<[ProductListModel], NetworkError>) -> Void) {
        // We can use here URLComponents and take foloowing fields as parameters.
        guard let url = URL(string: baseURL + appService.path) else {
            completion(.failure(.apiError))
            return
        }
        
        apiService?.request(url: url,
                            type: ProductListDTO.self) { result in
            switch result {
            case .success(let data):
                if let products = data.products {
                    let listModel = self.getProductList(products: products)
                    completion(.success(listModel))
                } else {
                    completion(.failure(.apiError))
                }
            case .failure(_):
                completion(.failure(.apiError))
            }
        }
    }
    
    private func getProductList(products: [Product]) -> [ProductListModel] {
        var result = [ProductListModel]()
        for item in products {
            result.append(ProductListModel(image: item.imageURL ?? "",
                                           name: item.title,
                                           price: item.price?[0].value,
                                           rating: item.ratingCount ?? 0.0,
                                           isFavourite: false))
        }
        return result
    }
}

