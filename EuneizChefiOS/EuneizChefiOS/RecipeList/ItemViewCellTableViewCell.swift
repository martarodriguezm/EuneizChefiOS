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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Personaliza la celda si es necesario
    }

    // Puedes agregar una función para configurar la celda
    func configureCell(recipe: Recipe) {
        recipeNameLabel.text = recipe.strMeal
        recipeImageView.loadImage(from: recipe.strMealThumb)
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
