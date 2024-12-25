//
//  User.swift
//  FinalProject
//
//  Created by Yunyi Wu on 05.12.2024..
//

import Foundation

//codable decodes raw json data and map to our data structure
//it is the opposite process of encoding which we did in authviewmodel
struct  User:Identifiable,Codable{
    let id:String
    let fullname:String
    let email:String
    
    //computed property to abbreviate user's initials
    var initials:String{
        let formatter=PersonNameComponentsFormatter()
        if let components=formatter.personNameComponents(from: fullname){
            formatter.style =  .abbreviated
            return formatter.string(from: components)
        }
        return ""
            
    }
}
//testing
extension User{
    static var MOCK_USER=User(id:NSUUID().uuidString, fullname: "Papacito Wu", email:"silly123@gmail.com")
}

