//
//  CategoryListContracts.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 5.08.2022.
//

import Foundation

protocol CategoryListViewModelProtocol {
    var delegate: CategoryListViewModelDelegate? { get set }
    func load()
}

enum CategoryListViewModelOutput: Equatable {
    
    case updateTitle(String)
    case setLoading(Bool)
    case showCategoryList([String])
}

protocol CategoryListViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: CategoryListViewModelOutput)
}
