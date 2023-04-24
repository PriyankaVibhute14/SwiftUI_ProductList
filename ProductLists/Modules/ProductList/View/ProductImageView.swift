//
//  ProductImageView.swift
//  ProductLists
//
//  Created by Priyanka Vibhute on 23/04/23.
//

import SwiftUI

struct ProductImageView: View {
    @ObservedObject var productImageModel: ProductListViewModel
    let cornerRadius = 20.0
    let width = 180.0
    static var defaultImage = UIImage(named: "defaultImage")
    
    init(urlString: String) {
        productImageModel = ProductListViewModel(isFavourite: false,
                                                 productListService: ProductListService(),
                                                 downloadImageService: DownloadImageService())
        productImageModel.getProductImage(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: productImageModel.productImage ?? ProductImageView.defaultImage!)
            .resizable()
            .cornerRadius(cornerRadius)
            .frame(width: width)
            .scaledToFit()
    }
}
