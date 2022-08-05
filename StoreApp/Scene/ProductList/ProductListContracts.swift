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
}

enum ProductListViewModelOutput: Equatable {
    
    case updateTitle(String)
    case setLoading(Bool)
    case showProductList([ProductListModel])
}

protocol ProductListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: ProductListViewModelOutput)
}
