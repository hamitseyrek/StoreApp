//
//  CategoryListVC.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 5.08.2022.
//

import UIKit

class CategoryListVC: UIViewController {
    
    let service: APIService? = APIService()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        service?.getCategories(completion: { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                print(response)
            }
        })
        // Do any additional setup after loading the view.
    }
}
