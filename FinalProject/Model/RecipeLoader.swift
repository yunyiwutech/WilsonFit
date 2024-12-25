//
//  RecipeLoader.swift
//  FinalProject
//
//  Created by Yunyi Wu on 09.12.2024..
//

import Foundation

class RecipeLoader {
    static func loadRecipes() -> [Recipe] {
        guard let url = Bundle.main.url(forResource: "recipes", withExtension: "json") else {
            print("Failed to locate recipes.json in bundle.")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let recipes = try JSONDecoder().decode([Recipe].self, from: data)
            return recipes
        } catch {
            print("Error loading recipes: \(error.localizedDescription)")
            return []
        }
    }
}
