//
//  ConvertUserList.swift
//  Hustings
//
//  Created by Matthew Sykes on 12/04/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//
//
//import Foundation
//import Firebase
//import FirebaseDatabase
//import FirebaseFirestore
//
//class ConvertUserList {
//    
//    let db = Firestore.firestore()
//    
//    func convertUserIDsToUsers(userIDs:[String]) -> [User] {
//        
//        var users = [User]()
//        
//        print("Converting UserIDs to Users")
//        
//        var count = 0
//        
//        for userID in userIDs {
//            count += 1
//            
//            print("User found")
//            
//            let docRef = db.collection("Users").document(userID)
//            
//            docRef.getDocument { (document, error) in
//                if let document = document, document.exists {
//                    let firstName = document.get("firstName") as! String?
//                    let lastName = document.get("lastName") as! String?
//                    let email = document.get("email") as! String?
//                    let classID = document.get("classID") as! String?
//                    
//                    print("User information stored")
//                
//                    if (firstName != nil && lastName != nil && email != nil && classID != nil) {
//                        users.append(
//                            User(userID: userID, displayName: "", email: email, firstName: firstName, lastName: lastName, classID: classID)
//                        )
//                        print("User created")
//                    }
//                    
//                } else {
//                    print("Error retreiving member user information.")
//                }
//                
//                if (count == userIDs.count) {
//                    return users
//                }
//            }
//        }
//        
//        print("User convertion complete")
//    }
//}
