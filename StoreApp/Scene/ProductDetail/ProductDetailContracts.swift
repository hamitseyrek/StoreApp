//
//  ProductDetailContracts.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 5.08.2022.
//

import Foundation

protocol ProductDetailViewModelProtocol {
    var delegate: ProductDetailViewModelDelegate? { get set }
    func load()
}

enum ProductDetailViewModelOutput {
    
    case updateTitle(String)
    case setLoading(Bool)
    case showDiscountProductList([DiscountProductModel])
    case allProductList([ProductListModel])
}

protocol ProductDetailViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: ProductDetailViewModelOutput)
    func showDetail(_ product: ProductDetailModel)
    func getDiscountPrices(_ productId: Int)
}
