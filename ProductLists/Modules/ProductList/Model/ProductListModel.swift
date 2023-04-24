//
//  ProductListModel.swift
//  ProductLists
//
//  Created by Priyanka Vibhute on 22/04/23.
//

import Foundation

struct ProductListModel: Identifiable {
    var id = UUID()
    let image: String
    let name: String
    let price: Double
    let rating: Double
    var isFavourite: Bool
}
