//
//  ProfileView.swift
//  FinalProject
//
//  Created by Yunyi Wu on 05.12.2024..
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel:AuthViewModel
    var body: some View {
        if let User=viewModel.currentUser{
            List{
                
                
                    Section{
                        HStack {
                            Text(User.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width:72,height:72)
                                .background(Color(.systemGray3))
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading,spacing: 4){
                                Text(User.fullname)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.top,4)
                                
                                Text(User.email)
                                    .font(.footnote)
                            }
                        }
                        
                        
                    }
                
                
                Section("General"){
                    settingsRow(imageName: "gear", title: "version", tintColor: Color(.systemGray))
                }
                
                Section("Account"){
                    Button{
                        viewModel.signOut()
                    }label:{
                        settingsRow(imageName: "arrow.left.circle.fill", title: "Sign out", tintColor: .red)
                    }
                    
                    Button{
                        print ("Delete  account..")
                    }label:{
                        settingsRow(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
