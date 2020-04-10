//
//  NewUserInfo.swift
//  Hustings
//
//  Created by Matthew Sykes on 06/04/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore

struct NewUserInfo: View {
    @EnvironmentObject var session: StoreSession
    
    @Binding var newUser:Bool
    @Binding var loadingView:Bool
    
    @State var currentUser:User? = nil
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var err:Bool? = false
    @State private var load = false
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    let db = Firestore.firestore()
    
    var body: some View {
        VStack(spacing: 10) {
            Image("HustingsLogoGreen")
                .resizable()
                .scaledToFit()
                .frame(minWidth: 0, maxWidth: 250)
                .padding(20)
            
            Text("Welcome to Hustings!")
                .foregroundColor(Color("HustingsGreen"))
                .font(.title)
            
            Text("Please enter your name below:")
                .foregroundColor(Color("HustingsGreen"))
            
            TextField("First Name", text: $firstName)
                .padding(20)
                .frame(minWidth: 250, maxWidth: 350)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("HustingsGreen"), lineWidth: 2)
                )
            
            TextField("Last Name", text: $lastName)
                .padding(20)
                .frame(minWidth: 250, maxWidth: 350)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("HustingsGreen"), lineWidth: 2)
                )
            
            Button(
                action: {
                    self.err = false
                    self.load = true
                    
                    if (self.checkIfName(nameToCheck: self.firstName) && self.checkIfName(nameToCheck: self.lastName)) {
                        if (self.currentUser != nil) {
                            // self.currentUser!.updateName(newFirstName: self.firstName, newLastName: self.lastName)
                            
                            self.db.collection("Users").document(self.currentUser!.getUserID()!).setData ([
                                "firstName": self.firstName,
                                "lastName": self.lastName,
                                "email": self.currentUser!.getEmail()
                            ]) { err in
                                if let err = self.err {
                                    self.showingAlert = true
                                    self.alertTitle = "Error Updating Database"
                                    self.alertMessage = "Please try again."
                                } else {
                                    print("Document updated.")
                                }
                            }
                            
                            self.loadingView = true
                            self.newUser = false
                        }
                    } else {
                        self.showingAlert = true
                        self.alertTitle = "Name Invalid"
                        self.alertMessage = "Please check your input has no special characters and is 3-20 characters in length."
                    }
                },
                label: {
                   Text("Create Profile")
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
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
            }
        )
    }
    
    func checkIfName(nameToCheck: String) -> Bool {
        let nameRegex = "^[a-zA-Z]{3,20}$"
        
        return nameToCheck.range(of: nameRegex, options: .regularExpression) != nil
    }
}
