//
//  AppContainer.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 5.08.2022.
//

import Foundation

import Foundation

let app = AppContainer()
let userDefaults = UserDefaults.standard

final class AppContainer {
    
    let router = AppRouter()
    let service = APIService()
}
