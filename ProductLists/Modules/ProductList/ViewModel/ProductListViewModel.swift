//
//  ProductListViewModel.swift
//  ProductLists
//
//  Created by Priyanka Vibhute on 22/04/23.
//

import Foundation
import SwiftUI

class ProductListViewModel: ObservableObject {
    var productListService: ProductListServiceProtocol?
    var downloadImageService: DownloadImageServiceProtocol?
    @Published var productList = [ProductListModel]()
    // This favourite array needs to be filled by getting response from API or Database. As this is assignment I am using temp solution.
    @Published var favouriteProducts = [ProductListModel]()
    @Published var isFavourite: Bool
    @Published var productImage: UIImage?
    @Published var isLoading: Bool = true
    var completion: (() -> ())?
    
    init(isFavourite: Bool,
         productListService: ProductListServiceProtocol,
         downloadImageService: DownloadImageServiceProtocol) {
        self.isFavourite = isFavourite
        self.productListService = productListService
        self.downloadImageService = downloadImageService
    }
    
    func getProductList() {
        productListService?.getProductList(completion: { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.productList = data
                    self?.isLoading = false
                    self?.completion?()
                }
            case .failure(_) :
                DispatchQueue.main.async {
                    //Need to show Error Popup on UI to handle this error but due to time constraint could't cover in this assignment.
                    self?.completion?()
                    self?.isLoading = false
                }
            }
        })
    }
    
    func getProductImage(urlString: String?) {
        downloadImageService?.getImage(url: urlString ?? "", completion: { [weak self] result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.productImage = image
                        self?.completion?()
                    }
                case .failure(let error):
                    //Need to show Error Popup on UI to handle this error but due to time constraint could't cover in this assignment.
                    DispatchQueue.main.async {
                        self?.completion?()
                        print(error)
                    }
                }
            })
        }
}
