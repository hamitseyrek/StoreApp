//
//  CategoryListVC.swift
//  StoreApp
//
//  Created by Hamit Seyrek on 5.08.2022.
//

import UIKit

class CategoryListVC: UIViewController {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.register(UINib(nibName: "CategoryListCell", bundle: Bundle.main), forCellReuseIdentifier: "CategoryListCell")
        }
    }
    
    var viewModel: CategoryListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    private var dataSource: UITableViewDiffableDataSource<Section, String>!
    private var categoryList: [String] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel.load()
        dataSource = getDataSource()
    }
}

extension CategoryListVC: CategoryListViewModelDelegate {
    
    func handleViewModelOutput(_ output: CategoryListViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            self.title = title.firstUppercased
        case .setLoading(let isLoading):
            self.loadingIndicator.isHidden = !isLoading
        case .showCategoryList(let categoryList):
            self.categoryList = categoryList
            self.updateDataSource()
        }
    }
    
    func navigare(to route: CategoryListViewRoute) {
        switch route {
        case .productList(let category):
            let viewController = AppBuilder.makeProductList(with: category)
            show(viewController, sender: nil)
        }
    }
}



extension CategoryListVC: UITableViewDelegate {
   
    func getDataSource() ->  UITableViewDiffableDataSource<Section, String> {
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryListCell", for: indexPath) as? CategoryListCell else {
                fatalError("Error dequing cell: Cell")
            }
            cell.categoryTitle?.text = itemIdentifier.firstUppercased
            return cell
        })
        
        return dataSource
    }
    
    func updateDataSource() {
        
        var snapShot = NSDiffableDataSourceSnapshot<Section,String>()
        snapShot.appendSections([.onlyOneSection])
        snapShot.appendItems(categoryList)
        
        dataSource.apply(snapShot, animatingDifferences: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCategory(at: indexPath.row)
    }
}
