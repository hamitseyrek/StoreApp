//
//  ProductDetailVC.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 5.08.2022.
//

import UIKit

class ProductDetailVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addButtonStyle: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.register(UINib(nibName: "ProductDetailCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ProductDetailCell")
        }
    }
    
    var viewModel: ProductDetailViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    var delege: AddButtonActionDelegate?
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, DiscountProductModel>!
    private var discountProductList: [DiscountProductModel] = []
    private var allProductList: [ProductListModel] = []
    private var productId: Int?
    private var isAddToCart: Bool = false
    private var discountLevel: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
        dataSource = getDataSource()
        configureCollectionView()
    }
    
    @IBAction func addToCartButtonClicked(_ sender: Any) {
        addButtonStyle.backgroundColor = .gray
        isAddToCart = true
        discountLevel += 1
        
        var productInCart: [Int] = []
        if let pro = userDefaults.array(forKey: "productInCart") as? [Int] {
            productInCart = pro
        }
        
        if let productId = productId {
            productInCart.append(productId)
            userDefaults.set(productInCart, forKey: "productInCart")
        }
        
        addButtonStyle.isEnabled = false
        updateDataSource()
    }
    
    func configureCollectionView() {
        
        let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionInset = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        layout?.minimumInteritemSpacing = 5
        layout?.itemSize = CGSize(width: (self.collectionView.frame.size.width - 72)/2, height: self.collectionView.frame.size.height/2.8)
    }
}

extension ProductDetailVC: ProductDetailViewModelDelegate {
    
    func handleViewModelOutput(_ output: ProductDetailViewModelOutput) {
        
        switch output {
        case .updateTitle(let title):
            self.title = title
        case .setLoading(let isLoading):
            self.loadingIndicator.isHidden = !isLoading
        case .showDiscountProductList(let discountProductList):
            self.discountProductList = discountProductList
            self.updateDataSource()
        case .allProductList(let productList):
            self.allProductList = productList
        }
    }
    
    func showDetail(_ product: ProductDetailModel) {
        
        self.productId = product.id
        self.titleLabel.text = product.title
        self.imageView.kf.setImage(with: URL(string: product.image), placeholder: UIImage(named: "indiBackground"))
        self.descriptionTextView.text = product.description
        self.priceLabel.text = "\(product.price) €"
        self.countLabel.text = "(\(product.rating.count))"
        
        RatingHelper.fillStar(rate: product.rating.rate, star1: self.star1, star2: self.star2, star3: self.star3, star4: self.star4, star5: self.star5)
    }
}

extension ProductDetailVC: UICollectionViewDelegate {
    
    func getDataSource() ->  UICollectionViewDiffableDataSource<Section, DiscountProductModel> {
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailCell", for: indexPath) as? ProductDetailCell else {
                fatalError("Error dequing cell: Cell")
            }
            
            let product = self.discountProductList[indexPath.row]
            cell.titleLabel?.text = product.title
            cell.priceLabel.text = "\(product.price.originalPrice) €"
            
            if let productDetail = self.allProductList.first (where: { $0.id == self.discountProductList[indexPath.row].id }) {
                
                cell.imageView.kf.setImage(with: URL(string:  productDetail.image), placeholder: UIImage(systemName: "photo.artframe"))
                cell.countLabel.text = "(\(productDetail.rating.rate))"
                
                RatingHelper.fillStar(rate: productDetail.rating.rate, star1: cell.star1, star2: cell.star2, star3: cell.star3, star4: cell.star4, star5: cell.star5)
            }
            
            var productInCart: [Int] = []
            if let pro = userDefaults.array(forKey: "productInCart") as? [Int] {
                productInCart = pro
            }
            
            if productInCart.contains(product.id) {
                cell.addButtonStyle.backgroundColor = .gray
            }
            
            if self.isAddToCart, let level = product.price.discountLevels.first (where: { $0.level == self.discountLevel })?.discountedPrice {
                cell.priceLabel.text = "\(String(describing: level)) €"
            }
            
            return cell
        })
        
        return dataSource
    }
    
    func updateDataSource() {
        
        var snapShot = NSDiffableDataSourceSnapshot<Section,DiscountProductModel>()
        snapShot.appendSections([.onlyOneSection])
        snapShot.appendItems(discountProductList)
        
        dataSource.apply(snapShot, animatingDifferences: true, completion: nil)
        
        if self.isAddToCart {
            self.collectionView.reloadData()
        }
    }
}

