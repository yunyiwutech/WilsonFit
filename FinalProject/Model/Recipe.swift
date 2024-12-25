//
//  Recipe.swift
//  FinalProject
//
//  Created by Yunyi Wu on 09.12.2024..
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id = UUID() // Unique ID for SwiftUI List
    let name: String
    let category: String
    let ingredients: [String]
    let calories: Int
    let dietType: [String]
    let copperContent: Double
}
