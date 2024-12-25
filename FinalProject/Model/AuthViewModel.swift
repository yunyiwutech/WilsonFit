//
//  AuthModel.swift
//  FinalProject
//
//  Created by Yunyi Wu on 05.12.2024..
//
import FirebaseAuth
import Foundation
import Firebase
import FirebaseFirestoreCombineSwift


//conform this protocol to all forms 
protocol AuthenticationFormProtocol{
    var formIsValid: Bool{get}
}

@MainActor
class AuthViewModel:ObservableObject{
    //user data object
    @Published var userSession:FirebaseAuth.User?
    //user data model
    @Published var currentUser:User?
    
    init(){
        self.userSession=Auth.auth().currentUser
        Task{
            await fetchUser()
        }
    }
    
    
    func signIn(withEmail email:String,password:String)async throws{
        do{
            let result=try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession=result.user
            await fetchUser()
        }catch{
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email:String,password:String,fullname:String)async throws{
        do{
            let result=try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession=result.user
            let user=User(id: result.user.uid, fullname: fullname, email: email)
            //encode user
           let encodedUser=try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        }catch{
            print("Failed to encode user\(error.localizedDescription)")
        }
        
    }
    
    func signOut(){
        //trigger 2 events
        //takes us back to login screen
        //firebase server logs us out
        do{
            try Auth.auth().signOut()//user sign out backend
            self.userSession=nil//takes us back to login screen
            self.currentUser=nil//wipes out current user 
        }catch{
            print("DEBUD:Failed to create user with error\(error.localizedDescription)")
        }
    }
    
    
    func fetchUser() async{
        guard let uid=Auth.auth().currentUser?.uid else {return}
        guard let snapshot=try? await Firestore.firestore().collection("users").document(uid).getDocument()else {return}
        self.currentUser=try? snapshot.data(as: User.self)
        print("Debug: Current user is \(self.currentUser)")
    }
    
    //delete user
    //optional
    
    func deleteAccount(){}
}

