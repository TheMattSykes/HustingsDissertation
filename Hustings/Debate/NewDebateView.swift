//
//  NewDebateView.swift
//  Hustings
//
//  Created by Matthew Sykes on 10/05/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

import SwiftUI
import Foundation
import Firebase

struct NewDebateView: View {
    
    @EnvironmentObject var session: StoreSession
    
    @Binding var currentState:DebateState
    
    @State var currentUser:User?
    
    @State private var debateName = "" {
        didSet {
            self.debateName = self.debateName.lowercased()
        }
    }
    
    @State private var debateQuestion = ""
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    let db = Firestore.firestore()
    
    var body: some View {
        VStack(spacing: 10) {
            TextField("New Debate Name", text: $debateName)
                .padding(20)
                .frame(minWidth: 250, maxWidth: 350)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("HustingsGreen"), lineWidth: 2)
                )
            
            TextField("Debate Question", text: $debateQuestion)
                .padding(20)
                .frame(minWidth: 250, maxWidth: 350)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("HustingsGreen"), lineWidth: 2)
                )
            HStack(spacing: 5) {
                Button(
                    action: {
                        self.createNewDebate()
                    },
                    label: {
                       Text("Create Debate")
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
                        self.currentState = .teacher_view
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
    
    func createNewDebate() {
        
        let debateDocRef = self.db.collection("Classes/\(currentUser!.getClassID()!)/Debates").document(self.debateName)
        
        if (debateQuestion != "") {
            debateDocRef.getDocument { (document, error) in
                if let document = document, !document.exists {
                    debateDocRef.setData ([
                        "topic": self.debateQuestion,
                        "for": [String](),
                        "against": [String](),
                        "messages": [String]()
                    ]) { err in
                        if let err = err {
                            print("An error occured: \(err)")
                            
                            self.showingAlert = true
                            self.alertTitle = "Error Creating Debate"
                            self.alertMessage = "Please ensure the debate name is unique and that you are connected to the internet."
                        } else {
                            print("Document updated.")
                        }
                    }
                } else {
                    self.showingAlert = true
                    self.alertTitle = "Debate Already Exists"
                    self.alertMessage = "A debate with that name already exists."
                }
            }
        } else {
            self.showingAlert = true
            self.alertTitle = "Error Creating Debate"
            self.alertMessage = "Please enter a debate question."
        }
    }
}

