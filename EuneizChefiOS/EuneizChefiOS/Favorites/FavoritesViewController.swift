//
//  FavoritesViewController.swift
//  EuneizChefiOS
//
//  Created by Student on 18/12/24.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let RECIPEDETAILS_SEGUE = "ShowRecipeDetailsSegue"
    
    @IBOutlet weak var tableView: UITableView!
    
    private var favoriteRecipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    
    private func loadFavorites() {
        favoriteRecipes = FavoritesManager.shared.getFavorites()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! ItemViewCell
        let recipe = favoriteRecipes[indexPath.row]
        cell.configureCell(recipe: recipe)
        return cell
    }
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = favoriteRecipes[indexPath.row]
        performSegue(withIdentifier: RECIPEDETAILS_SEGUE, sender: recipe)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == RECIPEDETAILS_SEGUE, let destinationVC = segue.destination as? RecipeDetailsViewController {
            if let recipe = sender as? Recipe {
                destinationVC.recipeId = recipe.idMeal
            }
        }
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

