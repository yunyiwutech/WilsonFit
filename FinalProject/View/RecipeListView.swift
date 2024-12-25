//
//  RecipeListView.swift
//  FinalProject
//
//  Created by Yunyi Wu on 09.12.2024..
//

import SwiftUI

struct RecipeListView: View {
    @State private var recipes: [Recipe] = []

    var body: some View {
        NavigationView {
            List(recipes) { recipe in
                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .font(.headline)
                    Text("Category: \(recipe.category)")
                        .font(.subheadline)
                    Text("Calories: \(recipe.calories)")
                        .font(.body)
                }
                .padding(.vertical, 5)
            }
            .navigationTitle("Recipes")
        }
        .onAppear {
            recipes = RecipeLoader.loadRecipes()
        }
    }
}

#Preview {
    RecipeListView()
}
