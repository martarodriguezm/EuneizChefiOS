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
}
