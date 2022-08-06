
## StoreApp

<img src="pokemon.gif" alt="gif1" style="width:400px;"/>

### Commits

1 - Initial Commit

* Setup project

2 - Configure app start. Connected network. Successful request categories and print them

* Create App folder (AppRouter, AppDelegate, AppBuilder)

* Create Network folder (NetworkRequest, NetworkError, Constants, APIService)

* Create README file

3 - Create CategoriesList page(Homepage)

* Create CategoryList page with MVVM Pattern

4 - created ProductList page

* Create ProductList page with collectionView. Configure CategoryList viewModel for link to ProductList

5 - created ProductDetail page

* Create ProductDetail page with scrollView. Configure ProductList viewModel for link to ProductDetail. 

6 - added sorted button to ProductList page

* sorting done with UICollectionViewDiffableDataSource (dont use any request to api)
* edited some issue on CategoryList page

7 - added action for AddToCartButton in ProductDetail page

* when add button doscounted item's price renewed
* and button backgrouncolor changed to gray

8 - configure rateStar and userDefault

* created starfilled helper
* when click the AddTobuttonCart the product id save to userDefault

9 - edit some issues of addToCart

* refactoring
* add readme gif



## Features

* MVVM
* Alamofire
* KingFisher
* UITableViewDiffableDataSource
* UICollectionViewDiffableDataSource
