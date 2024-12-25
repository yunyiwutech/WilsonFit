//
//  UserPage.swift
//  FinalProject
//
//  Created by Yunyi Wu on 03.12.2024..
//
import SwiftUI

import FirebaseFirestore
import FirebaseAuth
import FirebaseCore

      

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

struct AuthPage: View {
   
    var body: some View {
        VStack {
            
            LoginView()
           

            Spacer()
        }
        .padding()
    }
}



// Login View
struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    //environment object can only be casted
    //cause it is only initialized once
    @EnvironmentObject var viewModel:AuthViewModel

    var body: some View {
        NavigationStack{
            VStack() {
                Image("icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height:120)
                    .padding(.vertical,32)
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                //task unwrapping 
                Task{
                    try await viewModel.signIn(withEmail: email, password: password)
                }
                
            }) {
                Text("Log In")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                Spacer()
            }
            
            
            NavigationLink(){
                SignUpView()
            }label:{
                HStack(){
                    Text("Don't have an account?")
                    Text("Sign up")
                        .fontWeight(.bold)
                    
                }
                
            }
        }
            
        .padding()
        }
    }
}

// Sign-Up View
struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var fullname = ""
    @Environment(\.dismiss)var dismiss
    @EnvironmentObject var viewModel:AuthViewModel

    var body: some View {
        VStack(spacing: 16) {
            Image("icon")
                .resizable()
                .scaledToFill()
                .frame(width: 100,height:120)
                .padding(.vertical,32)
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            TextField("Full name", text: $fullname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                Task{
                    try await viewModel.createUser(withEmail: email, password: password, fullname: fullname)
                }
            }) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

#Preview {
    LoginView()
}

extension LoginView:AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count>5
        
    }
    
}

extension SignUpView:AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count>5
        && confirmPassword==password
        && !fullname.isEmpty
        
    }
    
}
