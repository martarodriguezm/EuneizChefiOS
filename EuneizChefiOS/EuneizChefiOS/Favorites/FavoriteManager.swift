//
//  FavoriteManager.swift
//  EuneizChefiOS
//
//  Created by Garoa Rojí Rodrigues on 7/1/25.
//

import Foundation

class FavoriteManager {
    static let shared = FavoriteManager()
    private let favoritesKey = "favoriteRecipesKey"
    
    // Obtener favoritos
    func loadFavorites() -> [FavoriteRecipe] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let favorites = try? JSONDecoder().decode([FavoriteRecipe].self, from: data) else {
            return []
        }
        return favorites
    }
    
    // Agregar receta a favoritos
    func addFavorite(recipe: FavoriteRecipe) {
        var favorites = loadFavorites()
        if !favorites.contains(where: { $0.idMeal == recipe.idMeal }) {
            favorites.append(recipe)
            saveFavorites(favorites: favorites)
        }
    }
    
    // Eliminar receta de favoritos
    func removeFavorite(recipe: FavoriteRecipe) {
        var favorites = loadFavorites()
        favorites.removeAll { $0.idMeal == recipe.idMeal }
        saveFavorites(favorites: favorites)
    }
    
    // Guardar favoritos
    private func saveFavorites(favorites: [FavoriteRecipe]) {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
}
