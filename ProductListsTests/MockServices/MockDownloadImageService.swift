//
//  MockDownloadImageService.swift
//  ProductListsTests
//
//  Created by Priyanka Vibhute on 23/04/23.
//

import Foundation
@testable import ProductLists
import UIKit

class MockDownloadImageService: BaseService, DownloadImageServiceProtocol {

    var result: Result<UIImage, NetworkError>
    
    init(result: Result<UIImage, NetworkError>) {
        self.result = result
    }
    
    func getImage(url: String, completion: @escaping (Result<UIImage, ProductLists.NetworkError>) -> Void) {
        completion(result)
    }
}
