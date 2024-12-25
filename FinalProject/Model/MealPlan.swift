//
//  MealPlan.swift
//  FinalProject
//
//  Created by Yunyi Wu on 09.12.2024..
//
import CoreData
import SwiftUI

func generateMealPlan(preferences: [String], recipes: [Recipe]) -> [String: Recipe] {
    // Filter recipes based on preferences and copper content
    let filteredRecipes = recipes.filter { recipe in
        let matchesDiet = preferences.isEmpty || preferences.allSatisfy { recipe.dietType.contains($0) }
        let safeCopper = recipe.copperContent <= 0.3 // Adjust threshold if needed
        return matchesDiet && safeCopper
    }
    
    // Assign recipes to meal categories
    let breakfast = filteredRecipes.first { $0.category == "Breakfast" }
    let lunch = filteredRecipes.first { $0.category == "Lunch" }
    let dinner = filteredRecipes.first { $0.category == "Dinner" }
    let snack = filteredRecipes.first { $0.category == "Snack" }
    
    // Return a structured meal plan
    return [
        "Breakfast": breakfast ?? Recipe(name: "No Meal", category: "Breakfast", ingredients: [], calories: 0, dietType: [], copperContent: 0),
        "Lunch": lunch ?? Recipe(name: "No Meal", category: "Lunch", ingredients: [], calories: 0, dietType: [], copperContent: 0),
        "Dinner": dinner ?? Recipe(name: "No Meal", category: "Dinner", ingredients: [], calories: 0, dietType: [], copperContent: 0),
        "Snack": snack ?? Recipe(name: "No Meal", category: "Snack", ingredients: [], calories: 0, dietType: [], copperContent: 0)
    ]
}



func saveMealPlan(mealPlan: [String: Recipe], context: NSManagedObjectContext) {
    let newMealPlan = MealPlan(context: context)
    newMealPlan.date = Date()
    newMealPlan.breakfast = mealPlan["Breakfast"]?.name ?? "No Meal"
    newMealPlan.lunch = mealPlan["Lunch"]?.name ?? "No Meal"
    newMealPlan.dinner = mealPlan["Dinner"]?.name ?? "No Meal"
    newMealPlan.snack = mealPlan["Snack"]?.name ?? "No Meal"

    do {
        try context.save()
        print("Meal plan saved successfully!")
    } catch {
        print("Error saving meal plan: \(error.localizedDescription)")
    }
}

func fetchMealPlans(context: NSManagedObjectContext) -> [MealPlan] {
    let fetchRequest: NSFetchRequest<MealPlan> = MealPlan.fetchRequest()
    do {
        return try context.fetch(fetchRequest)
    } catch {
        print("Error fetching meal plans: \(error.localizedDescription)")
        return []
    }
}
