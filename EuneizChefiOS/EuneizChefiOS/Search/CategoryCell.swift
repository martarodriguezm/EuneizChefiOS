//
//  CategoryCell.swift
//  EuneizChefiOS
//
//  Created by Garoa Rojí Rodrigues on 3/1/25.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    
    func configureCell(category: String) {
        categoryLabel.text = category
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Redondear las esquinas de la celda
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        // Agregar un borde a la celda
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.gray.cgColor  // Color gris para el borde
    }
}
