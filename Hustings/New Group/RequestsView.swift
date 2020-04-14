//
//  UserListTeacherClassView.swift
//  Hustings
//
//  Created by Matthew Sykes on 12/04/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore

struct RequestsView: View {
    @EnvironmentObject var session: StoreSession
    
    @State var currentUser:User? = nil
    
    @State var userIDs:[String] = [String]()
    @State var users:[User] = [User]()
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    let db = Firestore.firestore()
    
    var body: some View {
        VStack {
            List {
                ForEach((self.users), id: \.self.userID) { user in
                    HStack(spacing: 15) {
                        Text("\(user.getName() ?? "Name not available")")
                            .padding(10)
                        
                        Spacer()
                        
                        Button(
                              action: {
                                self.manageRequest(approveRequest: true, id: user.getUserID()!)
                              },
                              label: {
                                Text("Approve")
                              }
                          ).fixedSize()
                          .padding(10)
                          .frame(width: 100, height: 50)
                          .background(Color("HustingsGreen"))
                          .foregroundColor(.white)
                          .cornerRadius(15)
                    }
                }.onDelete(perform: delete) // when user swipes to delete
            }
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
                
                if (self.currentUser == nil) {
                    print("[WARNING] CurrentUser is NIL")
                }
                
                self.userIDs.removeAll()
                
                let docRef = self.db.collection("Classes").document(self.currentUser!.getClassID()!)
                
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        self.userIDs = document.get("requests") as? [String] ?? [""]
                        print("Member list found containing \(self.userIDs.count)")
                    } else {
                        print("Error locating class members")
                    }
                    
                    self.convertUserIDsToUsers()
                }
            }
        )
    }
    
    func manageRequest(approveRequest:Bool, id:String) {
        let classDocRef = self.db.collection("Classes").document(self.currentUser!.getClassID()!)
        let userDocRef = self.db.collection("Users").document(id)
        
        // User approves request to join class
        if (approveRequest) {
            classDocRef.updateData([
                "members": FieldValue.arrayUnion([id]),
                "requests": FieldValue.arrayRemove([id])
            ])
            
            userDocRef.updateData([
                "classID": self.currentUser!.getClassID()!
            ])
        } else { // User denies request
            classDocRef.updateData([
                "requests": FieldValue.arrayRemove([id])
            ])
        }
        
        userDocRef.updateData([
            "madeClassRequest": false
        ])
    }
        
    func convertUserIDsToUsers() {
        
        print("Converting UserIDs to Users")
        
        for userID in userIDs {
            print("User found")
            self.users.removeAll()
            
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
                            User(userID: userID, displayName: "", email: email, firstName: firstName, lastName: lastName, classID: classID)
                        )
                        print("User created")
                    }
                    
                } else {
                    print("Error retreiving member user information.")
                }
                
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        guard let index = Array(offsets).first else {
            return
        }
        
        manageRequest(approveRequest: false, id: users[index].getUserID()!)
        
        users.remove(at: index)
    }
}
