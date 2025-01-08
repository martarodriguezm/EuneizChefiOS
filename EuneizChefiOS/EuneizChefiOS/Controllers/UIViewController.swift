//
//  UIViewController.swift
//  EuneizChefiOS
//
//  Created by Garoa Rojí Rodrigues on 8/1/25.
//

import UIKit

extension UIViewController {
    func addFavoritesButton() {
        let heartButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(navigateToFavorites))
        heartButton.tintColor = .systemRed // Cambia el color del corazón si lo deseas
        navigationItem.rightBarButtonItem = heartButton
    }
    
    @objc private func navigateToFavorites() {
        // Navegar al FavoritesViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let favoritesVC = storyboard.instantiateViewController(withIdentifier: "FavoritesViewController") as? FavoritesViewController {
            navigationController?.pushViewController(favoritesVC, animated: true)
        }
    }
}

