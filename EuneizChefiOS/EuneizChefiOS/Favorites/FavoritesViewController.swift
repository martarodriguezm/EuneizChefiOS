//
//  FavoritesViewController.swift
//  EuneizChefiOS
//
//  Created by Student on 18/12/24.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var favoriteRecipes: [FavoriteRecipe] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Cargar las recetas favoritas
        loadFavoriteRecipes()
    }

    func loadFavoriteRecipes() {
        favoriteRecipes = FavoriteManager.shared.loadFavorites()
        tableView.reloadData()
    }
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteRecipeCell", for: indexPath)
        let recipe = favoriteRecipes[indexPath.row]
        cell.textLabel?.text = recipe.strMeal
        return cell
    }
}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

