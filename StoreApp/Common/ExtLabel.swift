//
//  ExtLabel.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 11.08.2022.
//

import Foundation
import UIKit

extension UILabel {
    func setColoredLabel(_ oldValue: String) {
        
        let string = NSMutableAttributedString(string: "\(oldValue)")
        string.setColorForText(oldValue, with: UIColor.red)
    
        self.attributedText = string
        
    }
    
    func setStrikeForText(_ textForStrike: String) {
        
        let string = NSAttributedString(
            string: textForStrike,
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        
        self.attributedText = string
    }
}
