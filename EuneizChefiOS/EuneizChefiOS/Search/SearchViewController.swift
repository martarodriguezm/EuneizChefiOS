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
    
    
    @IBOutlet weak var welcomeLabelText: UILabel!
    @IBOutlet weak var questionLabelText: UILabel!
    @IBOutlet weak var discoverLabelText: UILabel!
    @IBOutlet weak var byAreaLabelText: UILabel!
    @IBOutlet weak var byCategoryLabelText: UILabel!
    @IBOutlet weak var seeFavsLabelText: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var areasCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    // Variable para almacenar la consulta de búsqueda
    var searchQuery: String?

    var areas: [String] = []
    var categories: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="EuneizChef"
        
        addFavoritesButton()
        searchBar.delegate = self
        
        //Strings
        welcomeLabelText.text = String(localized: "welcomeLabelText")
        questionLabelText.text = String(localized: "questionLabelText")
        discoverLabelText.text = String(localized: "discoverLabelText")
        byAreaLabelText.text = String(localized: "byAreaLabelText")
        byCategoryLabelText.text = String(localized: "byCategoryLabelText")
        seeFavsLabelText.text = String(localized: "seeFavsLabelText")
        
        
        // Configuración de las colecciones
        areasCollectionView.delegate = self
        areasCollectionView.dataSource = self
                
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
                
        // Obtener las áreas y categorías de la API
        fetchAreas()
        fetchCategories()
    }
    
    @IBAction func onFavoritesButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: FAVORITES_SEGUE, sender: nil)
    }
    
    // Funión cuando se pulsa el botón de búsqueda en el teclado
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Verifica que el texto no esté vacío
        guard let query = searchBar.text, !query.isEmpty else { return }
            
        // Guarda la consulta en la variable
        searchQuery = query
            
        // Navega al siguiente ViewController usando un segue
        performSegue(withIdentifier: RECIPELIST_SEGUE, sender: self)
    }
    

    // Función para obtener las áreas disponibles desde la API de MealDB
    func fetchAreas() {
        let urlString = "https://www.themealdb.com/api/json/v1/1/list.php?a=list"
        
        // Solicitud con Alamofire
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
