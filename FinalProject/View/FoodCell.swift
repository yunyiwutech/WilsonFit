//
//  FoodCell.swift
//  FinalProject
//
//  Created by Yunyi Wu on 08.12.2024..
//

import SwiftUI

struct FoodCell: View {
    var food: Food

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(food.name ?? "Unknown Food")
                .font(.headline)
                .onAppear {
                    print("FoodCell rendering: \(food.name ?? "nil")")
                }
            Text("Category: \(food.category ?? "Unknown Category")")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("Reason: \(food.reason ?? "Unknown Reason")")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 5)
    }
}

