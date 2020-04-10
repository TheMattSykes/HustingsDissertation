//
//  NewClassView.swift
//  Hustings
//
//  Created by Matthew Sykes on 07/04/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore

struct NewClassView: View {
    
    @EnvironmentObject var session: StoreSession
    
    @Binding var currentState:ClassState
    
    @State var currentUser:User?
    
    @State private var className = ""
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    let db = Firestore.firestore()
    
    var body: some View {
        VStack(spacing: 10) {
            TextField("Unique Class Name", text: $className)
                .padding(20)
                .frame(minWidth: 250, maxWidth: 350)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("HustingsGreen"), lineWidth: 2)
                )
            HStack(spacing: 5) {
                Button(
                    action: {
                        self.db.collection("Classes").document(self.className).setData ([
                            "ownerID": self.currentUser?.getUserID() ?? "nil",
                            "members": [self.currentUser?.getUserID()],
                            "requests": [String]()
                        ]) { err in
                            if let err = err {
                                print("An error occured: \(err)")
                                
                                self.showingAlert = true
                                self.alertTitle = "Error Creating Class"
                                self.alertMessage = "Please ensure the class name is unique and that you are connected to the internet."
                            } else {
                                print("Document updated.")
                                
                                self.setUserClass()
                            }
                        }
                    },
                    label: {
                       Text("Create Class")
                    }
                    
                ).alert(isPresented: $showingAlert) {
                    Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
                }
                    .fixedSize()
                    .padding(10)
                    .frame(width: 140, height: 50)
                    .background(Color("HustingsGreen"))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                
                Button(
                    action: {
                        self.currentState = .empty
                    },
                    label: {
                       Text("Back")
                    }
                    
                )
                    .fixedSize()
                    .padding(10)
                    .frame(width: 140, height: 50)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
            }
        )
    }
    
    func setUserClass() {
        print("Setting user class...")
        self.db.collection("Users").document(self.currentUser!.getUserID()!).updateData ([
            "classID": self.className
        ]) { err in
            if let err = err {
                print("An error occured: \(err)")
                
                self.showingAlert = true
                self.alertTitle = "Error Creating Class"
                self.alertMessage = "Error setting user to class."
            } else {
                print("Document updated.")
                
                self.currentUser!.updateClassID(newClassID: self.className)
                self.session.updateSession(updatedUser: self.currentUser!)
                self.currentState = .main_teacher
            }
        }
    }
    
}
