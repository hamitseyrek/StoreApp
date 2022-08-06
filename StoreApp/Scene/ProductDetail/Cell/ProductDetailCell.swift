//
//  ProductDetailCell.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 6.08.2022.
//

import UIKit

class ProductDetailCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addButtonStyle: UIButton!
    
    var viewController: ProductDetailVC?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewController = ProductDetailVC()
    }
    @IBAction func addToCartButtonClicked(_ sender: Any) {
        addButtonStyle.isEnabled = false
        addButtonStyle.tintColor = .white
    }
}
