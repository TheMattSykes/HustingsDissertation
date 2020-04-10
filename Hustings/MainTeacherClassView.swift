//
//  MainTeacherClassView.swift
//  Hustings
//
//  Created by Matthew Sykes on 10/04/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore

struct MainTeacherClassView: View {
    @EnvironmentObject var session: StoreSession
    
    @Binding var currentState:ClassState
    
    @State var currentUser:User? = nil
    
    @State var userIDs:[String] = [String]()
    @State var users:[User] = [User]()
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationView() {
            VStack {
                Text("ClassID: \(String(describing: currentUser?.getClassID()))")
                Button(
                    action: {
                        
                    },
                    label: {
                       Text("Class Members")
                    }
                ).fixedSize()
                .padding(10)
                .frame(width: 140, height: 50)
                .background(Color("HustingsGreen"))
                .foregroundColor(.white)
                .cornerRadius(15)
                
                Button(
                    action: {
                        
                    },
                    label: {
                       Text("Member Requests")
                    }
                ).fixedSize()
                .padding(10)
                .frame(width: 140, height: 50)
                .background(Color("HustingsGreen"))
                .foregroundColor(.white)
                .cornerRadius(15)
                
                Button(
                    action: {
                        
                    },
                    label: {
                       Text("Delete Class")
                    }
                ).fixedSize()
                .padding(10)
                .frame(width: 140, height: 50)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(15)
            }
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
                
                if (self.currentUser == nil) {
                    print("[WARNING] CurrentUser is NIL")
                }
                
                // !!!!!!!!!!!!!!!!!!!!!!
                // THIS NEEDS FIXING!!!!!
                //
                
                self.userIDs.removeAll()
                
                let docRef = self.db.collection("Classes").document(self.currentUser!.getClassID()!)
                
//                self.db.collection("Classes/\(self.currentUser!.getClassID()!)").getDocuments() { (querySnapshot, err) in
//                    if let err = err {
//                        print("Error retrieving Topics: \(err)")
//                    } else {
//                        for document in querySnapshot!.documents {
//                            self.userIDs = document.get("members") as? [String] ?? [""]
//                        }
//                    }
//                }
            }
        )
    }
    
    func convertUserIDsToUsers() -> [User] {
        
        for userID in userIDs {
            self.users.removeAll()
            
            let docRef = self.db.collection("Users").document(userID)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let firstName = document.get("firstName") as! String?
                    let lastName = document.get("lastName") as! String?
                    let email = document.get("email") as! String?
                    let classID = document.get("classID") as! String?
                
                    if (firstName != nil && lastName != nil) {
                        self.users.append(
                            User(userID: userID, displayName: "", email: email, firstName: firstName, lastName: lastName, classID: classID)
                        )
                    }
                    
                } else {
                    
                }
                
            }
        }
        
        return [User]()
    }
}
