//
//  ProductListViewModel.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 5.08.2022.
//

import Foundation

final class ProductListViewModel: ProductListViewModelProtocol {
    
    weak var delegate: ProductListViewModelDelegate?
    private let service: APIServiceProtocol?
    private let category: String?
    
    init(service: APIServiceProtocol?, category: String) {
        self.service = service
        self.category = category
    }
    
    func load() {
        
        self.notify(.updateTitle(category ?? "Products"))
        notify(.setLoading(true))
        
        service?.getProducts(category: category!) { [weak self] result in
            
            guard let self = self else { return }
            self.notify(.setLoading(false))
            
            switch result {
            case .success(let response):
                self.notify(.showProductList(response))
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    private func notify(_ output: ProductListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
