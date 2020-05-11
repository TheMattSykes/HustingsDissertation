//
//  UserListTeacherClassView.swift
//  Hustings
//
//  Created by Matthew Sykes on 10/04/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase
//import FirebaseDatabase
//import FirebaseFirestore

struct UserListTeacherClassView: View {
    @EnvironmentObject var session: StoreSession
    
    @State var currentUser:User? = nil
    
    @State var userIDs:[String] = [String]()
    @State var users:[User] = [User]()
    
    @State var teacherView:TeacherView = .list
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    let db = Firestore.firestore()
    
    var body: some View {
        VStack {
            if (self.teacherView == .list) {
                NavigationView {
                    List {
                        ForEach((self.users), id: \.self.userID) { user in
                            NavigationLink(destination: TeacherViewScoresView(user: user)) {
                                Text("\(user.getName() ?? "Name not available")")
                            }
                        }.onDelete(perform: delete) // when user swipes to delete
                    }
                }
            } else {
                
            }
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
                self.teacherView = .list
                
                if (self.currentUser == nil) {
                    print("[WARNING] CurrentUser is NIL")
                }
                
                self.userIDs.removeAll()
                
                let docRef = self.db.collection("Classes").document(self.currentUser!.getClassID()!)
                
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        self.userIDs = document.get("members") as? [String] ?? [""]
                        print("Member list found containing \(self.userIDs.count)")
                    } else {
                        print("Error locating class members")
                    }
                    
                    self.convertUserIDsToUsers()
                    print("User count = \(self.users.count)")
                }
            }
        )
    }
    
    func convertUserIDsToUsers() {
        self.users.removeAll()
        
        for userID in userIDs {
            
            print("User found")
            
            let docRef = self.db.collection("Users").document(userID)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let firstName = document.get("firstName") as! String?
                    let lastName = document.get("lastName") as! String?
                    let email = document.get("email") as! String?
                    let classID = document.get("classID") as! String?
                    
                    print("User information stored")
                
                    if (firstName != nil && lastName != nil && email != nil && classID != nil) {
                        self.users.append(
                            User(userID: userID, displayName: "", email: email, firstName: firstName, lastName: lastName, classID: classID, classRequest: false)
                        )
                        print("User created")
                    }
                    
                } else {
                    print("Error retreiving member user information.")
                }
            }
        }
        
        print("User convertion complete")
    }
    
    func delete(at offsets: IndexSet) {
        guard let index = Array(offsets).first else {
            return
        }
        
        let id = users[index].getClassID()!
        let classDocRef = self.db.collection("Classes").document(self.currentUser!.getClassID()!)
        let userDocRef = self.db.collection("Users").document(id)
        
        classDocRef.updateData([
            "members": FieldValue.arrayRemove([id])
        ])
        
        userDocRef.updateData([
            "classID": FieldValue.delete(),
            "madeClassRequest": false
        ])
        
        users.remove(at: index)
    }
}

enum TeacherView {
    case list
    case profile
}
