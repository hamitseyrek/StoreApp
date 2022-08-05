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
    private var categories: [String] = []
    
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
                self.categories = response
                print("dode", response)
                self.notify(.showCategoryList(self.categories))
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func selectCategory(at index: Int) {
        let category = categories[index]
        print("************")
        print(category)
        print("************")
        delegate?.navigare(to: .productList(category: category))
    }
    
    private func notify(_ output: CategoryListViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
