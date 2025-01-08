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
}
