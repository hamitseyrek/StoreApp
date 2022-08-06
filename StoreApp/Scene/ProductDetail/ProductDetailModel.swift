//
//  ProductDetailModel.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 5.08.2022.
//

import Foundation

struct ProductDetailModel: Decodable {
    let id: Int
    let title, description, image, category: String
    let price: Double
    let rating: Rating
}

struct DiscountProductModel: Decodable {
    let id: Int
    let title: String
    let price: DiscountPrice
}

struct DiscountPrice: Decodable {
    let originalPrice: Double
    let discountLevels: [DiscountLevel]
}

struct DiscountLevel: Decodable {
    let level: Int
    let discountedPrice: Double
}

extension DiscountProductModel: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    public static func == (lhs: DiscountProductModel, rhs: DiscountProductModel) -> Bool {
        return lhs.id == rhs.id
    }
}
