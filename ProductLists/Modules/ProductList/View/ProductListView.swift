//
//  ProductListView.swift
//  ProductLists
//
//  Created by Priyanka Vibhute on 22/04/23.
//

import SwiftUI

struct ProductListView: View {
    private struct Constants {
        let innerSpacing = 20.0
        let cornerRadius = 20.0
        let productViewWidth = 180.0
        let productViewHeight = 300.0
        let smallPadding = 5.0
        let mediumPadding = 10.0
        let opacity = 0.5
        let smallCornerRadius = 15.0
        let bottomViewHeight = 50.0
    }
    
    private let constants = Constants()
    private var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    @ObservedObject private var productListViewModel: ProductListViewModel
    @State private var showDetailsScreen: Bool?
    @State private var index: Int?
    
    init(productListViewModel: ProductListViewModel) {
        self.productListViewModel = productListViewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if productListViewModel.isLoading ?? false {
                    ProgressView()
                } else {
                    VStack {
                        // we can handle this navigation using navigation links or navigation stack.
                        if showDetailsScreen ?? false {
                            if let productList = productListViewModel.productList {
                                ProductDetailsView(product: productList[index ?? 0], showDetailsScreen: $showDetailsScreen)
                            }
                        } else {
                            if productListViewModel.isFavourite ?? false {
                                productListView(products: productListViewModel.favouriteProducts ?? [])
                            } else {
                                productListView(products: productListViewModel.productList ?? [])
                            }
                        }
                        bottomNavigationView()
                        // we can take these strings from localization files.
                            .navigationTitle(Text("Product List"))
                    }
                }
            }
            .background(Color.pink.opacity(constants.opacity))
            .onAppear {
                showDetailsScreen = false
                index = 0
                productListViewModel.getProductList()
            }
        }
    }
    
    private func productListView(products: [ProductListModel]) -> some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: constants.innerSpacing) {
                ForEach(Array(products.enumerated()),
                        id: \.1.id) { (index, product) in
                    productView(product: product, selectedIndex: index)
                        .onTapGesture {
                            self.index = index
                            showDetailsScreen = true
                        }
                }
            }
            .padding()
        }
    }
    
    // we can create separate component for this product view so that it can be used at multiple places if required.
    private func productView(product: ProductListModel, selectedIndex: Int) -> some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom) {
                ProductImageView(urlString: product.image ?? "")
                VStack(alignment: .leading) {
                    Text(product.name ?? "")
                        .foregroundColor(Color.white)
                        .bold()
                    Text("₹ \(product.price ?? 0.0)")
                        .foregroundColor(Color.white)
                        .font(.caption)
                        .padding(.bottom, constants.smallPadding)
                    
                    Button {
                        // Add To Cart
                    } label: {
                        HStack {
                            Image(systemName: "cart")
                                .foregroundColor(Color.white)
                            Text("Add To Cart")
                                .foregroundColor(Color.white)
                        }
                        .padding(constants.mediumPadding)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: constants.smallCornerRadius)
                            .stroke(Color.white, lineWidth: 2))
                    
                }
                .padding()
                .frame(width: constants.productViewWidth)
                .background(Color.secondary)
                .cornerRadius(constants.cornerRadius)
            }
            .frame(width: constants.productViewWidth, height: constants.productViewHeight)
            .shadow(radius: 3)
            // This favourite array needs to be filled by getting response from API or Database. As this is assignment I am using temp solution.
            Button {
                if !(productListViewModel.isFavourite ?? false) {
                    if var product = productListViewModel.productList?[selectedIndex] {
                        if product.isFavourite ?? false {
                            productListViewModel.productList?[selectedIndex].isFavourite?.toggle()
                            product.isFavourite?.toggle()
                            productListViewModel.favouriteProducts = productListViewModel.favouriteProducts?.filter { $0.id != productListViewModel.productList?[selectedIndex].id }
                        } else {
                            productListViewModel.productList?[selectedIndex].isFavourite?.toggle()
                            product.isFavourite?.toggle()
                            if productListViewModel.favouriteProducts != nil {
                                productListViewModel.favouriteProducts?.append(product)
                            } else {
                                productListViewModel.favouriteProducts = [product]
                            }
                        }
                    }
                } else {
                    if let index = self.productListViewModel.productList?.firstIndex(where: {$0.id == productListViewModel.favouriteProducts?[selectedIndex].id}) {
                        productListViewModel.productList?[index].isFavourite?.toggle()
                    }

                    productListViewModel.favouriteProducts = productListViewModel.favouriteProducts?.filter { $0.id != productListViewModel.favouriteProducts?[selectedIndex].id }
                }
        } label: {
                Image(systemName: "heart")
                    .padding(constants.mediumPadding)
                    .foregroundColor(Color.white)
                    .background(product.isFavourite ?? false ? Color.accentColor : Color.secondary)
                    .cornerRadius(constants.bottomViewHeight)
                    .padding()
            }
        }
    }
    
    private func bottomNavigationView() -> some View {
        HStack {
            Spacer()
            Button {
                productListViewModel.isFavourite = false
            } label: {
                HStack {
                    Image(systemName: "grid")
                        .foregroundColor(Color.white)
                    Text("Products")
                        .foregroundColor(Color.white)
                }
                .padding(constants.smallPadding)
            }
            Spacer()
            Button {
                productListViewModel.isFavourite = true
            } label: {
                HStack {
                    Image(systemName: "heart")
                        .foregroundColor(Color.white)
                    Text("Favourites")
                        .foregroundColor(Color.white)
                }
                .padding(constants.smallPadding)
            }
            Spacer()
        }
        .frame(height: constants.bottomViewHeight)
        .background(Color.secondary)
        .cornerRadius(constants.cornerRadius)
        .padding(.horizontal, constants.mediumPadding)
        .padding(.bottom, 0)
        
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(productListViewModel: ProductListViewModel(isFavourite: false,
                                                                   productListService: ProductListService(),
                                                                   downloadImageService: DownloadImageService()))
    }
}
