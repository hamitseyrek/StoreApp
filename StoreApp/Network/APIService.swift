//
//  APIService.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 5.08.2022.
//

import Foundation
import Alamofire


protocol APIServiceProtocol {
    func getCategories(completion: @escaping (Result<[String], NetworkError >) -> Void)
    func getProductsByCategory(category: String, completion: @escaping (Result<[ProductListModel], NetworkError>) -> Void)
    func getSingleProduct(id: Int?, completion: @escaping (Result<ProductDetailModel, NetworkError>) -> Void)
    func getDiscountProducts(completion: @escaping (Result<[DiscountProductModel], NetworkError>) -> Void)
    func getAllProducts(completion: @escaping (Result<[ProductListModel], NetworkError>) -> Void)
}

struct APIService: APIServiceProtocol {
    
    func getCategories(completion: @escaping (Result<[String], NetworkError>) -> Void) {
        
        AF.request(Constants.categories.rawValue)
            .validate()
            .responseDecodable(of: [String].self) { (response) in
                
                guard response.error == nil else { return completion(.failure(.apiError)) }
                guard let products = response.value else { return completion(.failure(.serializationError)) }
                return completion(.success(products))
            }
    }
    
    func getProductsByCategory(category: String, completion: @escaping (Result<[ProductListModel], NetworkError>) -> Void) {
        
        let path = "\(Constants.productsByCategory.rawValue)/\(category)"
        
        AF.request(path.formatForPAth())
            .validate()
            .responseDecodable(of: [ProductListModel].self) { (response) in
                
                guard response.error == nil else { return completion(.failure(.invalidEndpoint)) }
                guard let products = response.value else { return completion(.failure(.serializationError)) }
                return completion(.success(products))
            }
    }
    
    func getSingleProduct(id: Int?, completion: @escaping (Result<ProductDetailModel, NetworkError>) -> Void) {
        
        guard let id = id else {
            return completion(.failure(.notExist))
        }
        
        let path = "\(Constants.singleProduct.rawValue)/\(id)"
        
        AF.request(path)
            .validate()
            .responseDecodable(of: ProductDetailModel.self) { (response) in
                
                guard response.error == nil else { return completion(.failure(.invalidEndpoint)) }
                guard let products = response.value else { return completion(.failure(.serializationError)) }
                return completion(.success(products))
            }
    }
    
    func getDiscountProducts(completion: @escaping (Result<[DiscountProductModel], NetworkError>) -> Void) {
        
        let path = "\(Constants.discountList.rawValue)"
        
        AF.request(path)
            .validate()
            .responseDecodable(of: [DiscountProductModel].self) { (response) in
                
                guard response.error == nil else { return completion(.failure(.invalidEndpoint)) }
                guard let products = response.value else { return completion(.failure(.serializationError)) }
                return completion(.success(products))
            }
    }
    
    func getAllProducts(completion: @escaping (Result<[ProductListModel], NetworkError>) -> Void) {
        
        let path = "\(Constants.singleProduct.rawValue)"
        
        AF.request(path.formatForPAth())
            .validate()
            .responseDecodable(of: [ProductListModel].self) { (response) in
                
                guard response.error == nil else { return completion(.failure(.invalidEndpoint)) }
                guard let products = response.value else { return completion(.failure(.serializationError)) }
                return completion(.success(products))
            }
    }

}
