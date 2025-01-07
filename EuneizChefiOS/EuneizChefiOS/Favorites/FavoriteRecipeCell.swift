//
//  FavoriteRecipeCell.swift
//  EuneizChefiOS
//
//  Created by Garoa Rojí Rodrigues on 7/1/25.
//

import UIKit

class FavoriteRecipeCell: UITableViewCell {
    
    // Conecta los elementos de la celda
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeCategoryLabel: UILabel!
    @IBOutlet weak var recipeAreaLabel: UILabel!
    @IBOutlet weak var favIcon: UIImageView!
    
    
    // Configura la celda con los datos de la receta
    func configureCell(RecipeResponse: FavoriteRecipe) {
        recipeNameLabel.text = RecipeResponse.strMeal
        recipeCategoryLabel.text = RecipeResponse.strCategory
        recipeAreaLabel.text = RecipeResponse.strArea
        recipeImageView.setImage(from: RecipeResponse.strMealThumb)
    }
}

// Extensión para UIImageView para cargar imágenes de manera asincrónica
extension UIImageView {
    func setImage(from urlString: String) {
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
