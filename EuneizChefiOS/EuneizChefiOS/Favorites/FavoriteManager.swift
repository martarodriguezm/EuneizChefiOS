//
//  FavoriteManager.swift
//  EuneizChefiOS
//
//  Created by Garoa Rojí Rodrigues on 7/1/25.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    private let favoritesFile = "favorites.json"
    private var favorites: [Recipe] = []

    private init() {
        loadFavorites()
    }

    func addFavorite(_ recipe: Recipe) {
        if !favorites.contains(where: { $0.idMeal == recipe.idMeal }) {
            favorites.append(recipe)
            saveFavorites()
        }
    }

    func removeFavorite(_ recipe: Recipe) {
        favorites.removeAll { $0.idMeal == recipe.idMeal }
        saveFavorites()
    }

    func isFavorite(_ recipe: Recipe) -> Bool {
        return favorites.contains(where: { $0.idMeal == recipe.idMeal })
    }

    func getFavorites() -> [Recipe] {
        return favorites
    }

    private func saveFavorites() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(favorites) {
            let url = getFileURL()
            try? data.write(to: url)
        }
    }

    private func loadFavorites() {
        let url = getFileURL()
        if let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            favorites = (try? decoder.decode([Recipe].self, from: data)) ?? []
        }
    }

    private func getFileURL() -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent(favoritesFile)
    }
}
