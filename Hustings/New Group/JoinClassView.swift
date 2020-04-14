//
//  JoinClassView.swift
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

struct JoinClassView: View {
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
            TextField("Class Name", text: $className)
                .padding(20)
                .frame(minWidth: 250, maxWidth: 350)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("HustingsGreen"), lineWidth: 2)
                )
            HStack(spacing: 5) {
                Button(
                    action: {
                        
                    },
                    label: {
                       Text("Join Class")
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
            }
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
            }
        )
    }
    
    func joinClass() {
        let userID = self.currentUser!.getUserID()!
        let classDocRef = self.db.collection("Classes").document(self.className)
        let userDocRef = self.db.collection("Users").document(userID)
        
        classDocRef.getDocument { (document, error) in
            if let document = document, document.exists {
                classDocRef.updateData([
                    "requests": FieldValue.arrayUnion([userID])
                ])
            }
        }
        
        userDocRef.getDocument { (document, error) in
            if let document = document, document.exists {
                userDocRef.updateData([
                    "madeClassRequest": true,
                    "requestedClassID": self.className
                ])
            }
        }
        
        self.currentState = .request_made
    }
}
