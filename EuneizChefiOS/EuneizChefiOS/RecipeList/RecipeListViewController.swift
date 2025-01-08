//
//  RecipeListViewController.swift
//  EuneizChefiOS
//
//  Created by Student on 18/12/24.
//
import UIKit
import Alamofire

class RecipeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let RECIPEDETAILS_SEGUE = "ShowRecipeDetailsSegue"
    
    // Variable para recibir la consulta de búsqueda
    var query: String?
    // Arreglo para almacenar las recetas obtenidas de la API
    var recipes: [Recipe] = []
    var availableAreas: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryOrAreaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Actualizar el label según la consulta o selección
        if let query = query {
            categoryOrAreaLabel.text = query
        }
        
        fetchRecipes()
    }
    
    // Función para realizar la solicitud a la API
    func fetchRecipes() {
        guard let query = query else { return }
        // Verifica si la consulta es un nombre de receta o un área
        let urlString: String
                
        if isAreaSearch(query) {
            // Si es un área, realiza una búsqueda de recetas por área
            urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(query)"
        } else {
            // Si es una búsqueda por nombre de receta, realiza la búsqueda por nombre
            urlString = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(query)"
        }
        
        // Realiza la solicitud con Alamofire
        AF.request(urlString).responseDecodable(of: RecipeResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.recipes = data.meals ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching recipes: \(error)")
            }
        }
    }
    
    // Función que verifica si el query es un área o no
    func isAreaSearch(_ query: String) -> Bool {
            return availableAreas.contains(query)
        }
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! ItemViewCell
        let recipe = recipes[indexPath.row]
        cell.configureCell(recipe: recipe)
        return cell
    }
}

// MARK: - Extension for loading images

