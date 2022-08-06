//
//  RatingHelper.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 6.08.2022.
//

import Foundation
import UIKit

enum RatingHelper {
    
    static func fillStar(rate: Double, star1: UIImageView, star2: UIImageView, star3: UIImageView, star4: UIImageView, star5: UIImageView) {
        
        if Int(rate) > 0 {
            star1.image = UIImage(named: "star_filled")
            if Int(rate) > 1 {
                star2.image = UIImage(named: "star_filled")
                if Int(rate) > 2 {
                    star3.image = UIImage(named: "star_filled")
                    if Int(rate) > 3 {
                        star4.image = UIImage(named: "star_filled")
                        if rate > 4.5 {
                            star5.image = UIImage(named: "star_filled")
                        }
                    }
                }
            }
        }
    }
}
