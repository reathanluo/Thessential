//
//  CategoryVC.swift
//  SelFit
//
//  Created by Reathan Luo on 2/2/22.
//

import UIKit
// Show the source in the tableview, maybe add icon to it,

class CategoryVC: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let categories = ["General", "Business", "Science", "Technology", "Health", "Entertainment", "Sports"]
//    var article: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        configNavbarAndSearchbar()
    }
    
    func configCollectionView() {
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(UINib(nibName: Constants.categoryCell, bundle: .main), forCellWithReuseIdentifier: Constants.categoryCellID)
    }
    
    func configNavbarAndSearchbar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "News"
        searchBar.delegate = self
        searchBar.placeholder = "Search for news"
        hideKeyboard()
    }
}


extension CategoryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.categoryCellID, for: indexPath) as! CategoryCell
        let categoryName = categories[indexPath.row]
        
        switch categoryName {
        case Constants.general:
            cell.backgroundColor = CategoryColor.generalColor.rawValue
        case Constants.business:
            cell.backgroundColor = CategoryColor.businessColor.rawValue
        case Constants.science:
            cell.backgroundColor = CategoryColor.scienceColor.rawValue
        case Constants.technology:
            cell.backgroundColor = CategoryColor.techColor.rawValue
        case Constants.health:
            cell.backgroundColor = CategoryColor.healthColor.rawValue
        case Constants.entertainment:
            cell.backgroundColor = CategoryColor.entertainColor.rawValue
        case Constants.sports:
            cell.backgroundColor = CategoryColor.sportsColor.rawValue
        default:
            cell.backgroundColor = CategoryColor.generalColor.rawValue
        }
        
        cell.categoryLabelName.text = categoryName
        cell.categoryLabelName.textColor = #colorLiteral(red: 0.05834504962, green: 0.05800623447, blue: 0.05861062557, alpha: 1)
        cell.newsSourceCategoryLabel.isHidden = true
        cell.newSourceCategoryColor.isHidden = true
        
        return cell
    }
}

extension CategoryVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row]
        NetworkManager.singleton.getArticles(passedInCategory: selectedCategory.lowercased()) { result in
            switch result {
            case let .success(gotArticles):
                //                print(gotArticles)
                let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let headLineVC  = sampleStoryBoard.instantiateViewController(withIdentifier: Constants.headlinesCellID) as! HeadlinesVC
                headLineVC.headlines = gotArticles!
                headLineVC.category = self.categories[indexPath.row]
                self.navigationController?.pushViewController(headLineVC, animated: true)
                
            case let .failure(gotError):
                print(gotError)
            }
        }
    }
}


// Search bar
extension CategoryVC: UISearchBarDelegate {
    
    func hideKeyboard() {
        // To hide the keyboard
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        // This to make sure other things are still clickable after hiding keyboard
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchQueryText = searchBar.text!
        searchBar.endEditing(true)
        
        // This to handle spaces
        var properSearchQuery = ""
        for letter in searchQueryText {
            if letter == " " {
                properSearchQuery += "%20" // To deal with space
            }else {
                properSearchQuery += String(letter)
            }
        }
        
        NetworkManager.singleton.getSearchArticles(passedInQuery: properSearchQuery) { result in
            switch result {
            case let .success(gotArticles):
                //                print(gotArticles)
                let getStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let headLineVC  = getStoryBoard.instantiateViewController(withIdentifier: Constants.headlinesCellID) as! HeadlinesVC
                headLineVC.headlines = gotArticles!
                if gotArticles!.isEmpty {
                    headLineVC.searchQuery = "No Results for \(searchQueryText)"
                    self.navigationController?.pushViewController(headLineVC, animated: true)
                    
                }else {
                    headLineVC.searchQuery = "Results for \(searchQueryText)"
                    self.navigationController?.pushViewController(headLineVC, animated: true)
                }
            case let .failure(gotError):
                print(gotError)
            }
        }
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != "" {
            return true
        } else {
            searchBar.placeholder = "Enter a search phrase"
            return false
        }
    }
    
}



extension UIColor {
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return NSString(format:"#%06x", rgb) as String
    }

}



extension UIColor {
  
  convenience init(_ hex: String, alpha: CGFloat = 1.0) {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) { cString.removeFirst() }
    
    if ((cString.count) != 6) {
        self.init("ff0000") // return red color for wrong hex input
      return
    }
    
    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: alpha)
  }

}
