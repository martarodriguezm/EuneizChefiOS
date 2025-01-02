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
    
    @IBOutlet weak var favoritesButton: UIButton!
    
    @IBOutlet weak var searchButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    @IBAction func onFavoritesButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: FAVORITES_SEGUE, sender: nil)
    }
    
    @IBAction func onSearchButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: SEARCH_SEGUE, sender: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == FAVORITES_SEGUE {
            if segue.destination is FavoritesViewController {
                // Configura favoritos si es necesario
            }
        } else if segue.identifier == SEARCH_SEGUE {
            if segue.destination is SearchViewController {
                // Configura búsqueda si es necesario
            }
        }
    }
}
