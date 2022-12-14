//
//  ProductListVC.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 5.08.2022.
//

import UIKit
import Kingfisher

class ProductListVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.register(UINib(nibName: "ProductListCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ProductListCell")
        }
    }
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var viewModel: ProductListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    private var dataSource: UICollectionViewDiffableDataSource<Section, ProductListModel>!
    private var productList: [ProductListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
        dataSource = getDataSource()
        configureCollectionView()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .done, target: self, action: #selector(sortProductList))
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func sortProductList() {
        self.productList = self.productList.reversed()
        updateDataSource()
    }
    
    func configureCollectionView() {
        
        let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 0, right: 15)
        layout?.minimumInteritemSpacing = 4
        layout?.itemSize = CGSize(width: (self.collectionView.frame.size.width - 60)/2, height: self.collectionView.frame.size.height/3)
    }
}

extension ProductListVC: ProductListViewModelDelegate {
    
    func handleViewModelOutput(_ output: ProductListViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title.firstUppercased
        case .setLoading(let isLoading):
            self.loadingIndicator.isHidden = !isLoading
        case .showProductList(let productList):
            self.productList = productList
            self.updateDataSource()
        }
    }
    
    func navigare(to route: ProductListViewRoute) {
        switch route {
        case .productDetail(let id):
            let viewController = AppBuilder.makeProductDetail(with: id)
            show(viewController, sender: nil)
        }
    }
}

extension ProductListVC: UICollectionViewDelegate {
    
    func getDataSource() ->  UICollectionViewDiffableDataSource<Section, ProductListModel> {
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as? ProductListCell else {
                fatalError("Error dequing cell: Cell")
            }
            
            let product = self.productList[indexPath.row]
            cell.titleLabel?.text = product.title
            cell.imageView.kf.setImage(with: URL(string: product.image), placeholder: UIImage(systemName: "rays"))
            cell.priceLabel.text = "\(product.price) ???"
            cell.ratingCountLabel.text = "(\(product.rating.rate))"
            
            RatingHelper.fillStar(rate: product.rating.rate, star1: cell.star1, star2: cell.star2, star3: cell.star3, star4: cell.star4, star5: cell.star5)
            
            return cell
        })
        
        return dataSource
    }
    
    func updateDataSource() {
        
        var snapShot = NSDiffableDataSourceSnapshot<Section,ProductListModel>()
        snapShot.appendSections([.onlyOneSection])
        snapShot.appendItems(productList)
        
        dataSource.apply(snapShot, animatingDifferences: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.productList[indexPath.row]
        viewModel.selectProduct(id: product.id)
    }
}
