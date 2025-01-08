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
    @IBOutlet weak var favIcon: UIImageView!
    
    var currentRecipe: Recipe?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Permitir clickeo en la celda
        self.isUserInteractionEnabled = true
        
        // Agregar un borde gris y esquinas redondeadas a la celda
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 10  // Radio de las esquinas
        self.contentView.layer.borderWidth = 1    // Ancho del borde
        self.contentView.layer.borderColor = UIColor.gray.cgColor // Color gris para el borde
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleFavorite))
                favIcon.isUserInteractionEnabled = true
                favIcon.addGestureRecognizer(tapGesture)
            }
    
    func configureCell(recipe: Recipe) {
        currentRecipe = recipe
        recipeNameLabel.text = recipe.strMeal
        recipeCategoryLabel.text = recipe.strCategory
        recipeAreaLabel.text = recipe.strArea
        recipeImageView.loadImage(from: recipe.strMealThumb)
        updateFavoriteIcon()
    }
    override func layoutSubviews() {
            super.layoutSubviews()
        }
    
    @objc private func toggleFavorite() {
            guard let recipe = currentRecipe else { return }
            if FavoritesManager.shared.isFavorite(recipe) {
                FavoritesManager.shared.removeFavorite(recipe)
            } else {
                FavoritesManager.shared.addFavorite(recipe)
            }
            updateFavoriteIcon()
        }
    
    func updateFavoriteIcon() {
            guard let recipe = currentRecipe else { return }
            favIcon.image = FavoritesManager.shared.isFavorite(recipe) ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
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


