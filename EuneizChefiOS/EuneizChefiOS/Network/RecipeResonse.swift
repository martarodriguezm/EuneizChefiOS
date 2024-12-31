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
}
