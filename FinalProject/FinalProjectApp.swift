//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by Yunyi Wu on 02.12.2024..
//

import SwiftUI
import Firebase

@main
struct FinalProjectApp: App {
    //pass in authviewmodel as an environment object
    //so now we have it everywhere
    let persistenceController = PersistenceController.shared

    @StateObject var viewModel=AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext) // Inject Core Data context
            

        }
    }
}
