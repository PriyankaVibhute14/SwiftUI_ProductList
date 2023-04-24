//
//  ProductListViewModelTests.swift
//  ProductListsTests
//
//  Created by Priyanka Vibhute on 23/04/23.
//

import XCTest
@testable import ProductLists

final class ProductListViewModelTests: XCTestCase {
    func test_productList_API_success() {
        let mockProductListService = MockProductListService(result: .success(getProductListModel()))
        let mockDownloadImageService = MockDownloadImageService(result: .failure(NetworkError.apiError))
        let viewModel = ProductListViewModel(isFavourite: false,
                                       productListService: mockProductListService,
                                       downloadImageService: mockDownloadImageService)
        viewModel.getProductList()
        let exp = expectation(description: "Loading..")
        viewModel.completion = {
            exp.fulfill()
        }
        waitForExpectations(timeout: 2)
        XCTAssertEqual(viewModel.productList.count, 4)
    }
    
    func test_productList_API_failure() {
        let mockProductListService = MockProductListService(result: .failure(NetworkError.apiError))
        let mockDownloadImageService = MockDownloadImageService(result: .failure(NetworkError.apiError))
        let viewModel = ProductListViewModel(isFavourite: false,
                                       productListService: mockProductListService,
                                       downloadImageService: mockDownloadImageService)
        viewModel.getProductList()
        let exp = expectation(description: "LoadingFailureList..")
        viewModel.completion = {
            exp.fulfill()
        }
        waitForExpectations(timeout: 2)
        XCTAssertEqual(viewModel.productList.count, 0)
    }
    
    func test_download_image_API_success() {
        let mockProductListService = MockProductListService(result: .success(getProductListModel()))
        let mockDownloadImageService = MockDownloadImageService(result: .success(UIImage()))
        let viewModel = ProductListViewModel(isFavourite: false,
                                       productListService: mockProductListService,
                                       downloadImageService: mockDownloadImageService)
        let exp = expectation(description: "LoadingImage..")
        viewModel.getProductImage(urlString: "")
        viewModel.completion = {
            exp.fulfill()
        }
        waitForExpectations(timeout: 2)
        XCTAssertNotNil(viewModel.productImage)
    }
    
    func test_download_image_API_failure() {
        let mockProductListService = MockProductListService(result: .failure(NetworkError.apiError))
        let mockDownloadImageService = MockDownloadImageService(result: .failure(NetworkError.apiError))
        let viewModel = ProductListViewModel(isFavourite: false,
                                       productListService: mockProductListService,
                                       downloadImageService: mockDownloadImageService)
        let exp = expectation(description: "LoadingFailureImage..")
        viewModel.getProductImage(urlString: "")
        viewModel.completion = {
            exp.fulfill()
        }
        waitForExpectations(timeout: 2)
        XCTAssertNil(viewModel.productImage)
    }
        
    func getProductListModel() -> [ProductListModel] {
        return [ProductListModel(image: "",
                                 name: "",
                                 price: 0.0,
                                 rating: 0.0,
                                 isFavourite: false),
                ProductListModel(image: "",
                                 name: "",
                                 price: 0.0,
                                 rating: 0.0,
                                 isFavourite: false),
                ProductListModel(image: "",
                                 name: "",
                                 price: 0.0,
                                 rating: 0.0,
                                 isFavourite: false),
                ProductListModel(image: "",
                                 name: "",
                                 price: 0.0,
                                 rating: 0.0,
                                 isFavourite: false)]
    }
}
