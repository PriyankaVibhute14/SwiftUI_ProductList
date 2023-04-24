//
//  MockProductListService.swift
//  ProductListsTests
//
//  Created by Priyanka Vibhute on 23/04/23.
//


import Foundation
@testable import ProductLists

class MockProductListService: BaseService, ProductListServiceProtocol {

    var result: Result<[ProductListModel], NetworkError>
    
    init(result: Result<[ProductListModel], NetworkError>) {
        self.result = result
    }
    
    func getProductList(completion: @escaping (Result<[ProductLists.ProductListModel], ProductLists.NetworkError>) -> Void) {
        completion(result)
    }
}

