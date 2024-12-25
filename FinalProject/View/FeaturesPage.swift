//
//  FeaturesPage.swift
//  FinalProject
//
//  Created by Yunyi Wu on 02.12.2024..
//

import SwiftUI


struct FeaturesPage: View {
    var body: some View {
        VStack {
            Text("Features")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom)
            
            FeatureCard(iconName: "person.2.crop.square.stack.fill",
                        description: "An app designed to generate diet plans for people with Wilson's disease")
            
            FeatureCard(iconName: "heart.fill", description: "Forever free to use")
        }
        .padding()
    }
}


#Preview {
    FeaturesPage()
}
