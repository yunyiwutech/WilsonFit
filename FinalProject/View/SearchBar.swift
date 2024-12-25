//
//  SearchBar.swift
//  FinalProject
//
//  Created by Yunyi Wu on 08.12.2024..
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search foods...", text: $text)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
        }
    }
}
