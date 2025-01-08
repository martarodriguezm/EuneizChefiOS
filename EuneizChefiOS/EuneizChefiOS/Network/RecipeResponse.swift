//
//  RecipeResonse.swift
//  EuneizChefiOS
//
//  Created by Garoa Rojí Rodrigues on 31/12/24.
//

struct RecipeResponse: Codable {
    let meals: [Recipe]?
}

struct Recipe: Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strArea: String?
    let strCategory: String?
}

// Modelo para la respuesta de áreas
struct AreaResponse: Codable {
    let meals: [Area]?
}

// Modelo para cada área
struct Area: Codable {
    let strArea: String
}

// Modelo para la respuesta de categorías
struct CategoryResponse: Codable {
    let meals: [Category]?
}

// Modelo para cada categoría
struct Category: Codable {
    let strCategory: String
}
