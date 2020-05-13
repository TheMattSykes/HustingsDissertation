//
//  ClassView.swift
//  Hustings
//
//  Created by Matthew Sykes on 27/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase
//import FirebaseDatabase
//import FirebaseFirestore

/**
 Primary class view, determines which view the system should output.
 */
struct ClassView: View {
    
    @EnvironmentObject var session: StoreSession
    @State var currentUser:User? = nil
    @State var currentState:ClassState = .empty
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    let db = Firestore.firestore()
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Image(systemName: "person.3.fill")
                    .foregroundColor((Color("HustingsGreen")))
                    .font(.largeTitle)
                Text("Class")
                    .foregroundColor((Color("HustingsGreen")))
                    .font(.largeTitle)
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
            }
            
            // Determine which view to present
            if (self.currentState == .empty) {
                EmptyClassView(currentUser: $currentUser, currentState: $currentState)
            }
            
            if (self.currentState == .new) {
                NewClassView(currentState: $currentState)
            }
            
            if (self.currentState == .join) {
                JoinClassView(currentState: $currentState)
            }
            
            if (self.currentState == .main_teacher) {
                MainTeacherClassView(currentState: $currentState)
            }
            
            if (self.currentState == .main_student) {
                MainStudentClassView(currentState: $currentState)
            }
            
            if (self.currentState == .request_made) {
                RequestMadeView(currentUser: $currentUser, currentState: $currentState)
            }
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
                
                if (self.currentUser!.getMadeClassRequest()) {
                    self.currentState = .request_made
                } else {
                    if (self.currentUser!.getClassID() == nil) {
                         self.currentState = .empty
                    } else {
                        let docRef = self.db.collection("Classes").document(self.currentUser!.getClassID()!)
                         
                        docRef.getDocument { (document, error) in
                            if let document = document, document.exists {
                                let ownerID = document.get("ownerID") as! String?
                                
                                if (ownerID == self.currentUser!.getUserID()!) {
                                    self.currentState = .main_teacher
                                } else {
                                    self.currentState = .main_student
                                }
                            } else {
                                // if class no longer exists
                                self.leaveClass()
                                
                                self.showingAlert = true
                                self.alertTitle = "Error Locating Class"
                                self.alertMessage = "The class associated with your profile could not be found. Your associated class information has been deleted."
                                self.currentState = .empty
                            }
                            
                        }
                    }
                }
            }
        )
    }
    
    /**
     Delete class information from user, if the user requests to leave the class
     */
    func leaveClass() {
        let docRef = self.db.collection("Users").document(self.currentUser!.getUserID()!)
        
        // Push to database
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                docRef.updateData([
                    "classID": FieldValue.delete()
                ])
            } else {
                self.showingAlert = true
                self.alertTitle = "Unable to locate user data"
                self.alertMessage = "Please try again later."
            }
        }
    }
}

/**
 enum to determine current class view.
 */
enum ClassState {
    case empty
    case new
    case join
    case main_student
    case main_teacher
    case request_made
}

