//
//  SearchViewController.swift
//  EuneizChefiOS
//
//  Created by Student on 18/12/24.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let RECIPELIST_SEGUE = "ShowRecipeListSegue"
    let FAVORITES_SEGUE = "ShowFavoritesSegue"
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var favoritesButton: UIButton!
    
    @IBOutlet weak var areasCollectionView: UICollectionView! // Colección para las áreas
    @IBOutlet weak var categoriesCollectionView: UICollectionView! // Colección para las categorías
    
    // Variable para almacenar la consulta de búsqueda
    var searchQuery: String?

    var areas: [String] = []
    var categories: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        // Configuración de las colecciones
        areasCollectionView.delegate = self
        areasCollectionView.dataSource = self
                
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
                
        // Obtén las áreas y categorías de la API
        fetchAreas()
        fetchCategories()
    }
    
    @IBAction func onFavoritesButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: FAVORITES_SEGUE, sender: nil)
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
    

    // Función para obtener las áreas disponibles desde la API de MealDB
    func fetchAreas() {
        let urlString = "https://www.themealdb.com/api/json/v1/1/list.php?a=list"
        
        // Realiza la solicitud con Alamofire
        AF.request(urlString).responseDecodable(of: AreaResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.areas = data.meals?.compactMap { $0.strArea } ?? [] // Almacena los nombres de las áreas
                DispatchQueue.main.async {
                    self.areasCollectionView.reloadData() // Recarga la colección con los nuevos datos
                }
            case .failure(let error):
                print("Error fetching areas: \(error)")
            }
        }
    }
    
    // Función para obtener las categorías disponibles
    func fetchCategories() {
        let urlString = "https://www.themealdb.com/api/json/v1/1/list.php?c=list"
            
        AF.request(urlString).responseDecodable(of: CategoryResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.categories = data.meals?.compactMap { $0.strCategory } ?? []
                DispatchQueue.main.async {
                    self.categoriesCollectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching categories: \(error)")
            }
        }
    }

    // MARK: - UICollectionView DataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == areasCollectionView {
            return areas.count
        } else {
            return categories.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == areasCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCell", for: indexPath) as! AreaCell
            let area = areas[indexPath.row]
            cell.configureCell(area: area)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            let category = categories[indexPath.row]
            cell.configureCell(category: category)
            return cell
        }
    }
    
    // MARK: - UICollectionView Delegate

    // Al seleccionar una celda, realiza una búsqueda y redirige a RecipeListViewController
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == areasCollectionView {
            let selectedArea = areas[indexPath.row]
            performSegue(withIdentifier: RECIPELIST_SEGUE, sender: selectedArea)
        } else if collectionView == categoriesCollectionView {
            let selectedCategory = categories[indexPath.row]
            performSegue(withIdentifier: RECIPELIST_SEGUE, sender: selectedCategory)
        }
    }

    
    // MARK: - Prepare for Segue

    // Prepara el segue para pasar el área seleccionada a RecipeListViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == RECIPELIST_SEGUE, let destinationVC = segue.destination as? RecipeListViewController {
                    if let areaOrCategory = sender as? String {
                        destinationVC.query = areaOrCategory
                        destinationVC.availableAreas = self.areas
                    } else if let searchQuery = searchQuery {
                        destinationVC.query = searchQuery
                        destinationVC.availableAreas = self.areas
                    }
        } else if segue.identifier == FAVORITES_SEGUE {
            if segue.destination is FavoritesViewController {
                // Configura favoritos si es necesario
            }
        }
    }
}
