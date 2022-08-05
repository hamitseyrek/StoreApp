//
//  CategoryListViewModel.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 5.08.2022.
//

import Foundation

final class CategoryListViewModel: CategoryListViewModelProtocol {
    
    weak var delegate: CategoryListViewModelDelegate?
    private let service: APIServiceProtocol
    
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    func load() {
        
        notify(.updateTitle("Categories"))
        
        notify(.setLoading(true))
        
        service.getCategories { [weak self] result in
            
            guard let self = self else { return }
            self.notify(.setLoading(false))
            
            switch result {
            case .success(let response):
                let categories = response
                self.notify(.showCategoryList(categories))
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    private func notify(_ output: CategoryListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
