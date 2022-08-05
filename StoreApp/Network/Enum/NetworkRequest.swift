//
//  NetworkRequest.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 5.08.2022.
//

import Foundation
import Alamofire

enum NetworkRequest {
    
    static func networkRequest<T: Decodable>(path: String, completion: @escaping (Result<T,NetworkError>) -> Void) {
        
        AF.request(path)
          .validate()
          .responseDecodable(of: T.self) { (response) in
              
              guard response.error == nil else { return completion(.failure(.invalidEndpoint)) }
              guard let product = response.value else { return completion(.failure(.serializationError)) }
              return completion(.success(product))
          }
    }
}
