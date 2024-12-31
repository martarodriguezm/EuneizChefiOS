//
//  ViewController.swift
//  EuneizChefiOS
//
//  Created by Student on 18/12/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UISearchBarDelegate {
    let FAVORITES_SEGUE = "ShowFavoritesSegue"
    let SEARCH_SEGUE = "ShowSearchSegue"
    
    @IBOutlet weak var searchBar: UISearchBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        navigateToRecipeList(query: query)
    }
    
    func navigateToRecipeList(query: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let recipeListVC = storyboard.instantiateViewController(withIdentifier: "RecipeListViewController") as? RecipeListViewController {
             recipeListVC.query = query
             navigationController?.pushViewController(recipeListVC, animated: true)
        }
    }
    
}

