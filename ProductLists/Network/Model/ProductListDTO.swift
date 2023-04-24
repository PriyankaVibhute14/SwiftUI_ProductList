//
//  ProductListDTO.swift
//  ProductLists
//
//  Created by Priyanka Vibhute on 22/04/23.
//

import Foundation

struct ProductListDTO: Codable {
    let products: [Product]
}

struct Product: Codable {
    let citrusID: String?
    let title, id: String
    let imageURL: String
    let price: [Price]
    let brand: String
    let badges: [String]
    let ratingCount: Double
    let messages: Messages
    let isAddToCartEnable: Bool
    let addToCartButtonText: AddToCartButtonText
    let isInTrolley, isInWishlist: Bool
    let purchaseTypes: [PurchaseTypeElement]
    let isFindMeEnable: Bool
    let saleUnitPrice: Double
    let totalReviewCount: Int
    let isDeliveryOnly, isDirectFromSupplier: Bool

    enum CodingKeys: String, CodingKey {
        case citrusID = "citrusId"
        case title, id, imageURL, price, brand, badges, ratingCount, messages, isAddToCartEnable, addToCartButtonText, isInTrolley, isInWishlist, purchaseTypes, isFindMeEnable, saleUnitPrice, totalReviewCount, isDeliveryOnly, isDirectFromSupplier
    }
}

enum AddToCartButtonText: String, Codable {
    case addToCart = "Add to cart"
    case editQuantity = "Edit quantity"
}

struct Messages: Codable {
    let secondaryMessage: String?
    let sash: Sash
    let promotionalMessage: String?
}

struct Sash: Codable {
}

struct Price: Codable {
    let message: Message
    let value: Double
    let isOfferPrice: Bool
}

enum Message: String, Codable {
    case inAnySix = "in any six"
    case perBottle = "per bottle"
}

struct PurchaseTypeElement: Codable {
    let purchaseType: PurchaseTypeEnum
    let displayName: DisplayName
    let unitPrice: Double
    let minQtyLimit, maxQtyLimit, cartQty: Int
}

enum DisplayName: String, Codable {
    case case6 = "case (6)"
    case each = "each"
    case perBottle = "per bottle"
    case perCaseOf6 = "per case of 6"
}

enum PurchaseTypeEnum: String, Codable {
    case bottle = "Bottle"
    case purchaseTypeCase = "Case"
}
