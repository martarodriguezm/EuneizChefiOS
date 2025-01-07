//
//  ItemViewCellTableViewCell.swift
//  EuneizChefiOS
//
//  Created by Garoa Rojí Rodrigues on 3/1/25.
//

import UIKit

class ItemViewCell: UITableViewCell {
    // Conectar los elementos de la celda
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeCategoryLabel: UILabel!
    @IBOutlet weak var recipeAreaLabel: UILabel!
    @IBOutlet weak var favIcon: UIView!
    
    var recipe: Recipe?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Personaliza la celda si es necesario
        setupFavoriteIcon()
    }
    
    // Puedes agregar una función para configurar la celda
    func configureCell(recipe: Recipe) {
        self.recipe = recipe
        recipeNameLabel.text = recipe.strMeal
        recipeCategoryLabel.text = recipe.strCategory
        recipeAreaLabel.text = recipe.strArea
        recipeImageView.loadImage(from: recipe.strMealThumb)
        setupFavoriteIcon()
    }
    
    
    // Configura el icono de favorito
    private func setupFavoriteIcon() {
        guard let recipe = recipe else { return }
        let favorites = FavoriteManager.shared.loadFavorites()
        if favorites.contains(where: { $0.idMeal == recipe.idMeal }) {
            favIcon.backgroundColor = .yellow // El ícono se llena
        } else {
            favIcon.backgroundColor = .clear // El ícono está vacío
        }
    }
    
    @IBAction func toggleFavorite(_ sender: UITapGestureRecognizer) {
        guard let recipe = recipe else { return }
        
        // Verifica si la receta está en favoritos
        let favorites = FavoriteManager.shared.loadFavorites()
        if favorites.contains(where: { $0.idMeal == recipe.idMeal }) {
            // Si ya está en favoritos, la eliminamos
            FavoriteManager.shared.removeFavorite(recipe: FavoriteRecipe(idMeal: recipe.idMeal, strMeal: recipe.strMeal, strMealThumb: recipe.strMealThumb, strArea: recipe.strArea, strCategory: recipe.strCategory))
        } else {
            // Si no está en favoritos, la agregamos
            FavoriteManager.shared.addFavorite(recipe: FavoriteRecipe(idMeal: recipe.idMeal, strMeal: recipe.strMeal, strMealThumb: recipe.strMealThumb, strArea: recipe.strArea, strCategory: recipe.strCategory))
        }
        
        // Actualiza el icono
        setupFavoriteIcon()
    }
}
    // Extensión para UIImageView para cargar imágenes de manera asincrónica
    extension UIImageView {
        func loadImage(from urlString: String) {
            guard let url = URL(string: urlString) else { return }
            
            // Realiza la carga de la imagen en un hilo de fondo
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image // Asigna la imagen al UIImageView en el hilo principal
                    }
                }
            }
        }
    }


