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
    
    var query: String?
    var recipes: [Recipe] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchRecipes()
    }
    
    func fetchRecipes() {
        guard let query = query else { return }
        let urlString = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(query)"
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
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.strMeal
        cell.imageView?.loadImage(from: recipe.strMealThumb)
        return cell
    }
}

// MARK: - Extension for loading images
extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}

