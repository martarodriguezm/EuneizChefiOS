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
    let RECIPELIST_SEGUE = "ShowRecipeListSegue"
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var favoritesButton: UIButton!
    
    @IBOutlet weak var searchButton: UIButton!
    
    // Variable para almacenar la consulta de búsqueda
    var searchQuery: String?

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
    
    // Este método se ejecuta cuando se presiona el botón de búsqueda en el teclado
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Verifica que el texto no esté vacío
        guard let query = searchBar.text, !query.isEmpty else { return }
            
        // Guarda la consulta en la variable
        searchQuery = query
            
        // Realiza la transición al siguiente ViewController usando un segue
        performSegue(withIdentifier: RECIPELIST_SEGUE, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == RECIPELIST_SEGUE  {
            if let destinationVC = segue.destination as? RecipeListViewController {
                destinationVC.query = searchQuery
            }
        } else if segue.identifier == FAVORITES_SEGUE {
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
