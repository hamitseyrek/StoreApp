//
//  ProductListContracts.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 5.08.2022.
//

import Foundation

protocol ProductListViewModelProtocol {
    var delegate: ProductListViewModelDelegate? { get set }
    func load()
    func selectProduct(id: Int)
}

enum ProductListViewModelOutput: Equatable {
    
    case updateTitle(String)
    case setLoading(Bool)
    case showProductList([ProductListModel])
}

enum ProductListViewRoute {
    case productDetail(id: Int)
}

protocol ProductListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: ProductListViewModelOutput)
    func navigare(to route: ProductListViewRoute)
}
