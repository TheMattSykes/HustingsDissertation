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
import FirebaseDatabase
import FirebaseFirestore

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
            
            if (self.currentState == .empty) {
                EmptyClassView(currentUser: $currentUser, currentState: $currentState)
            }
            
            if (self.currentState == .new) {
                NewClassView(currentState: $currentState)
            }
            
            if (self.currentState == .join) {
                Text("Join mode")
            }
            
            if (self.currentState == .main_teacher) {
                MainTeacherClassView(currentState: $currentState)
            }
            
            if (self.currentState == .main_student) {
                Text("Currently joined to class as a student \(currentUser!.getClassID()!)")
            }
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
                
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
                            self.showingAlert = true
                            self.alertTitle = "Error Locating Class"
                            self.alertMessage = "Please try again."
                            self.currentState = .empty
                        }
                    }
                }
            }
        )
    }
}

enum ClassState {
    case empty
    case new
    case join
    case main_student
    case main_teacher
}

