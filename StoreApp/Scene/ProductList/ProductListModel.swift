//
//  ProductListModel.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 5.08.2022.
//

import Foundation

struct ProductListModel: Decodable, Equatable {
    let id: Int
    let title, description, image, category: String
    let price: Double
    let rating: Rating
}

struct Rating: Decodable, Equatable {
    let count: Int
    let rate: Double
}

extension ProductListModel: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    public static func == (lhs: ProductListModel, rhs: ProductListModel) -> Bool {
        return lhs.id == rhs.id
    }
}
