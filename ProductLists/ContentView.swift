//
//  ContentView.swift
//  ProductLists
//
//  Created by Priyanka Vibhute on 21/04/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ProductListView(productListViewModel: ProductListViewModel(isFavourite: false,
                                                                   productListService: ProductListService(),
                                                                   downloadImageService: DownloadImageService()))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

