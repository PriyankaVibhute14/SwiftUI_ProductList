//
//  ProductDetailsView.swift
//  ProductLists
//
//  Created by Priyanka Vibhute on 22/04/23.
//

import SwiftUI

struct ProductDetailsView: View {
    private struct Constants {
        let mediumPadding = 10.0
        let productViewWidth = 180.0
        let productViewHeight = 220.0
        let smallPadding = 5.0
        let topPadding = 60.0
    }
    
    private let constants = Constants()
    var product: ProductListModel
    @Binding var showDetailsScreen: Bool
    
    var body: some View {
        VStack(spacing: constants.smallPadding) {
            ProductImageView(urlString: product.image)
                .frame(width: constants.productViewWidth, height: constants.productViewHeight)
                .padding(.top, constants.topPadding)
            Text(product.name)
                .font(.title)
                .bold()
            Text(String("₹ \(product.price)"))
                .font(.headline)
            Text(String("\(product.rating)*"))
                .font(.headline)
            Spacer()
        }
        // we can take these strings from localization files.
        .navigationTitle(Text("Product Details"))
        .navigationBarItems(trailing: closeButton())
    }
    
    func closeButton() -> some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    showDetailsScreen = false
                }) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .padding(constants.mediumPadding)
                        .foregroundColor(.black)
                        .scaledToFit()
                }
                .frame(width: constants.topPadding, height: constants.topPadding)
            }
            .padding(.top, constants.smallPadding)
        }
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    @State static var showDetailsScreen = false
    static var previews: some View {
        ProductDetailsView(product: ProductListModel(image: "",
                                                     name: "",
                                                     price: 4.0,
                                                     rating: 4.0,
                                                     isFavourite: false),
                           showDetailsScreen: $showDetailsScreen)
    }
}
