//
//  DebateView.swift
//  Hustings
//
//  Created by Matthew Sykes on 27/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase

struct DebateView: View {
    
    @EnvironmentObject var session: StoreSession
    @State var currentUser:User? = nil
    @State var currentState:DebateState = .no_class
    
    @State var userIDList:[String] = [String]()
    @State var userList:[User] = [User]()
    
    @State var isTeacher:Bool = false
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    let db = Firestore.firestore()
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "exclamationmark.bubble")
                    .foregroundColor((Color("HustingsGreen")))
                    .font(.largeTitle)
                Text("Debate")
                    .foregroundColor((Color("HustingsGreen")))
                    .font(.largeTitle)
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
            }
            
            Spacer()
            
            // No class assigned to user
            if (currentState == .no_class) {
                Text("You need to join a class to take part in debates.")
            }
            
            if (currentState == .teacher_view) {
                MainTeacherDebateView(currentState: $currentState)
            }
            
            if (currentState == .new) {
                NewDebateView(currentState: $currentState, userIDList: userIDList)
            }
            
            if (currentState == .debate_list_teacher) {
                DebateListTeacherView(currentState: $currentState)
            }
            
            Spacer()
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
                
                if (self.currentUser!.getClassID() != nil) {
                    let docRef = self.db.collection("Classes").document(self.currentUser!.getClassID()!)
                     
                    docRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let ownerID = document.get("ownerID") as! String?
                            
                            if (ownerID == self.currentUser!.getUserID()!) {
                                self.getUserIDList()
                                
                                self.isTeacher = true
                            } else {
                                self.currentState = .student_view
                            }
                        } else {
                            self.showingAlert = true
                            self.alertTitle = "Error Locating Class"
                            self.alertMessage = "Please try again."
                            self.currentState = .no_class
                        }
                        
                    }
                }
            }
        )
    }
    
    func getUserIDList() {
        let docRef = self.db.collection("Classes").document(self.currentUser!.getClassID()!)
         
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.userIDList = document.get("members") as! [String]
                
                if (self.userIDList.count > 0) {
                    self.convertUserIDsToUsers()
                }
            } else {
                self.showingAlert = true
                self.alertTitle = "Error Locating Class Members"
                self.alertMessage = "Please try again."
                self.currentState = .no_class
            }
        }
    }
    
    func convertUserIDsToUsers() {
        self.userList.removeAll()
        
        for userID in userIDList {
            
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
                        self.userList.append(
                            User(userID: userID, displayName: "", email: email, firstName: firstName, lastName: lastName, classID: classID, classRequest: false)
                        )
                        print("User created")
                    }
                    
                } else {
                    print("Error retreiving member user information.")
                }
            }
        }
        
        self.currentState = .teacher_view
        
        print("User convertion complete")
    }
    
}

enum DebateState {
    case no_class
    case teacher_view
    case student_view
    case new
    case debate_list_teacher
    case debate_list_student
    case view_messages_teacher
    case view_messages_student
    case manage_debates
}
