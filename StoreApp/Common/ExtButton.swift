//
//  ExtButton.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 11.08.2022.
//

import Foundation
import UIKit

extension UIButton {
    func changeStyleForAddToCart() {
        self.backgroundColor = .gray
        self.tintColor = .white
        self.isUserInteractionEnabled = false
    }
}
