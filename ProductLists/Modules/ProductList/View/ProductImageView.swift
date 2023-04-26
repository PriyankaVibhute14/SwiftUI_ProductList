//
//  ProductImageView.swift
//  ProductLists
//
//  Created by Priyanka Vibhute on 23/04/23.
//

import SwiftUI

struct ProductImageView: View {
    @ObservedObject private var productImageModel: ProductListViewModel
    private let cornerRadius = 20.0
    private let width = 180.0
    var defaultImage = UIImage(named: "defaultImage") ?? UIImage()
    
    init(urlString: String) {
        productImageModel = ProductListViewModel(isFavourite: false,
                                                 productListService: ProductListService(),
                                                 downloadImageService: DownloadImageService())
        productImageModel.getProductImage(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: productImageModel.productImage ?? defaultImage)
            .resizable()
            .cornerRadius(cornerRadius)
            .frame(width: width)
            .scaledToFit()
    }
}
