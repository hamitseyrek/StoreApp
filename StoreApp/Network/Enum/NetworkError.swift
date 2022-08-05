//
//  NetworkError.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 5.08.2022.
//

import Foundation

enum NetworkError: String, Error {
    
    case apiError = "Failed to fetch data"
    case invalidEndpoint = "Invalid endpoint"
    case serializationError = "Failed to decode data"
}
