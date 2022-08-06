//
//  ProductDetailViewModel.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 5.08.2022.
//

import Foundation

final class ProductDetailViewModel: ProductDetailViewModelProtocol {
    
    weak var delegate: ProductDetailViewModelDelegate?
    private let service: APIServiceProtocol?
    private let id: Int?
    
    init(service: APIServiceProtocol?, id: Int) {
        self.service = service
        self.id = id
    }
    
    func load() {
        
        service?.getSingleProduct(id: self.id) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let productDetail):
                self.delegate?.showDetail(productDetail)
                self.delegate?.handleViewModelOutput(.updateTitle(productDetail.title))
            case .failure(let error):
                print(error.rawValue)
            }
        }
        
        delegate?.handleViewModelOutput(.setLoading(true))
        
        service?.getDiscountProducts(completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let discountProductList):
                self.delegate?.handleViewModelOutput(.showDiscountProductList(discountProductList))
            case .failure(let error):
                print(error.rawValue)
            }
        })
        
        service?.getAllProducts(completion: { [weak self] result in
            guard let self = self else { return }
            
            self.delegate?.handleViewModelOutput(.setLoading(false))
            
            switch result {
            case .success(let allProductListModel):
                self.delegate?.handleViewModelOutput(.allProductList(allProductListModel))
            case .failure(let error):
                print(error.rawValue)
            }
        })
    }
    
    func selectProduct(at index: Int) {
        
    }
    
    private func notify(_ output: ProductDetailViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
