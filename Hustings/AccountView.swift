//
//  AccountView.swift
//  Hustings
//
//  Created by Matthew Sykes on 27/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase

struct AccountView: View {
    
    @EnvironmentObject var session: StoreSession
    @State var currentUser:User? = nil
    
    @State private var showAlert = false
    @State private var showDeleteAlert = false
    
    let db = Firestore.firestore()
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "person.circle")
                    .foregroundColor((Color("HustingsGreen")))
                    .font(.largeTitle)
                Text("My Account")
                    .foregroundColor((Color("HustingsGreen")))
                    .font(.largeTitle)
            }
            
            if (currentUser != nil) {
                Text("Name: \(currentUser!.getName() ?? "Error retrieving name.")")
                Text("Email: \(currentUser!.getEmail())")
            } else {
                Text("Error retieving user information.")
            }

            Button(
                action: {
                    print("Attempting to log out...")
                    let signedOut = self.session.logOut()
                    
                    if (!signedOut) {
                        self.showAlert = true
                    }
                },
                label: {
                    Text("Sign Out")
                    
                }
            ).alert(isPresented: self.$showAlert) {
                Alert(title: Text("Sign Out Error"), message: Text("An error occured while signing out. Please try again."), dismissButton: .default(Text("OK")))
            }
                .fixedSize()
                .padding(10)
                .frame(width: 150, height: 50)
                .background(Color("HustingsGreen"))
                .foregroundColor(.white)
                .cornerRadius(15)
            
            Button(
                action: {
                    print("Attempting to log out...")
                    // let signedOut = self.session.deleteAccount()
                    
                    self.showDeleteAlert = true
                },
                label: {
                    Text("Delete Account")
                    
                }
            ).alert(isPresented: $showDeleteAlert) {
                Alert(title: Text("Delete Account"), message: Text("Are you sure you want to delete your account? This action cannot be undone!"), primaryButton: .destructive(Text("Delete")) {
                        self.deleteAccount()
                    }, secondaryButton: .cancel())
            }
                .fixedSize()
                .padding(10)
                .frame(width: 150, height: 50)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(15)
            
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
            }
        )
    }
    
    func deleteAccount() {
        self.db.collection("Users/").document(self.currentUser!.getUserID()!).delete()
        
        self.session.deleteAccount()
    }
}
