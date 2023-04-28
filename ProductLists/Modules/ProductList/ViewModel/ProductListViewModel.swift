//
//  ProductListViewModel.swift
//  ProductLists
//
//  Created by Priyanka Vibhute on 22/04/23.
//

import Foundation
import SwiftUI

class ProductListViewModel: ObservableObject {
    private var productListService: ProductListServiceProtocol?
    private var downloadImageService: DownloadImageServiceProtocol?
    @Published var isFavourite: Bool?
    @Published var productImage: UIImage?
    @Published var isLoading: Bool?
    @Published var productList : [ProductListModel]?
    // This favourite array needs to be filled by getting response from API or Database. As this is assignment I am using temp solution.
    @Published var favouriteProducts : [ProductListModel]?
    
    init(isFavourite: Bool?,
         productListService: ProductListServiceProtocol,
         downloadImageService: DownloadImageServiceProtocol) {
        self.isFavourite = isFavourite
        self.productListService = productListService
        self.downloadImageService = downloadImageService
    }
    
    func getProductList(completion: (() -> ())? = nil) {
        isLoading = true
        productListService?.getProductList(completion: { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.productList = data
                    self?.isLoading = false
                    completion?()
                }
            case .failure(_) :
                DispatchQueue.main.async {
                    //Need to show Error Popup on UI to handle this error but due to time constraint could't cover in this assignment.
                    completion?()
                    self?.isLoading = false
                }
            }
        })
    }
    
    func getProductImage(urlString: String?, completion: (() -> ())? = nil) {
        downloadImageService?.getImage(url: urlString ?? "", completion: { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.productImage = image
                    completion?()
                }
            case .failure(_):
                //Need to show Error Popup on UI to handle this error but due to time constraint could't cover in this assignment.
                DispatchQueue.main.async {
                    completion?()
                }
            }
        })
    }
}
