//
//  AppBuilder.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 5.08.2022.
//

import Foundation
import UIKit

final class AppBuilder {
    
    static func makeHome() -> CategoryListVC {
        
        let viewController = CategoryListVC(nibName: "CategoryListVC", bundle: Bundle.main)
        viewController.viewModel = CategoryListViewModel(service: app.service)
        return viewController
    }
    
    static func makeProductList(with category: String) -> ProductListVC {
        
        let viewController = ProductListVC(nibName: "ProductListVC", bundle: Bundle.main)
        viewController.viewModel = ProductListViewModel(service: app.service, category: category)
        
        return viewController
    }
}
