//
//  AreaCell.swift
//  EuneizChefiOS
//
//  Created by Garoa Rojí Rodrigues on 3/1/25.
//

import UIKit

class AreaCell: UICollectionViewCell {
    
    // IBOutlet para mostrar el nombre del área
    @IBOutlet weak var areaNameLabel: UILabel!
    
    // Función para configurar la celda con el nombre del área
    func configureCell(area: String) {
        areaNameLabel.text = area
    }
    
    override func awakeFromNib() {
           super.awakeFromNib()
           
           // Redondear las esquinas de la celda
           self.layer.cornerRadius = 10
           self.layer.masksToBounds = true
           // Agregar un borde a la celda
           self.layer.borderWidth = 3
           self.layer.borderColor =  UIColor(red: 1.0, green: 0.8, blue: 0.7, alpha: 1.0).cgColor
       }
}
