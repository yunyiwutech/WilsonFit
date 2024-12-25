//
//  WelcomePage.swift
//  FinalProject
//
//  Created by Yunyi Wu on 02.12.2024..
//

import SwiftUI

let gradientColors:[Color]=[.gradientTop,
    .gradientBottom]


struct WelcomePage: View {
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 150, height: 150)
                    .foregroundStyle(.tint)
                
                Image( "icon")
                    .resizable() // Makes the image resizable
                        .aspectRatio(contentMode: .fit) // Maintains aspect ratio within its container
                        .frame(width: 100, height: 100)
                    
            }
            
           
               
            
            
                
        }
       
        .padding()
        
    }
}


#Preview {
    WelcomePage()
}
