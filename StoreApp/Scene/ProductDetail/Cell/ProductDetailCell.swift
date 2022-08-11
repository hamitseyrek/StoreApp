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
    @IBOutlet weak var priceOldLabel: UILabel!
    @IBOutlet weak var addButtonStyle: UIButton!
    
    var productId: Int!
    
    var viewModel: ProductDetailViewModelProtocol!
    
    var productInCart: [Int] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let pro = userDefaults.array(forKey: "productInCart") as? [Int] {
            productInCart = pro
        }
    }
    
    @IBAction func addToCartButtonClicked(_ sender: Any) {
        viewModel.delegate?.getDiscountPrices(productId)
    }
}
