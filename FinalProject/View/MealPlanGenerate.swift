//
//  MealPanGenerate.swift
//  FinalProject
//
//  Created by Yunyi Wu on 09.12.2024..
//

import SwiftUI

struct MealPlanTestView: View {
    @Environment(\.managedObjectContext) var context
    @State private var mealPlan: [String: Recipe] = [:]
    private let recipes: [Recipe] = RecipeLoader.loadRecipes() // Load predefined recipes
    
    var body: some View {
        VStack {
            // Button to generate a meal plan
            Button(action: {
                mealPlan = generateMealPlan(preferences: ["vegetarian"], recipes: recipes)
            }) {
                Text("Generate Meal Plan")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            // Button to save the meal plan
            Button(action: {
                saveMealPlan(mealPlan: mealPlan, context: context)
            }) {
                Text("Save Meal Plan")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            // Display the meal plan
            List {
                ForEach(mealPlan.keys.sorted(), id: \.self) { mealType in
                    if let recipe = mealPlan[mealType] {
                        Section(header: Text(mealType)) {
                            Text(recipe.name)
                                .font(.headline)
                            Text("Calories: \(recipe.calories)")
                                .font(.subheadline)
                            Text("Ingredients: \(recipe.ingredients.joined(separator: ", "))")
                                .font(.body)
                        }
                    }
                }
            }
        }
        .navigationTitle("Meal Plan Test")
    }
}

#Preview{
    MealPlanTestView()
}
