//
//  LoadProfileView.swift
//  Hustings
//
//  Created by Matthew Sykes on 06/04/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase
//import FirebaseDatabase
//import FirebaseFirestore

/**
 Loading screen when user successfully logs in. Gets profile information from the database.
 */
struct LoadProfileView: View {
    
    @EnvironmentObject var session: StoreSession
    
    @Binding var loadingView:Bool
    @Binding var newUser:Bool
    
    @State var currentUser:User? = nil
    
    let db = Firestore.firestore()
    
    var body: some View {
        VStack(spacing: 10) {
            Image("HustingsLogoGreen")
                .resizable()
                .scaledToFit()
                .frame(minWidth: 0, maxWidth: 250)
                .padding(20)
            
            Text("Loading...")
                .foregroundColor(Color("HustingsGreen"))
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
                
                let docRef = self.db.collection("Users").document(self.currentUser!.getUserID()!)
                
                // Get user data
                docRef.getDocument { (document, error) in
                    print("Attempting to get user's name...")
                    if let document = document, document.exists {
                        print("Information exists. Accessing...")
                        let firstName = document.get("firstName") as! String?
                        let lastName = document.get("lastName") as! String?
                        print("Name: \(String(describing: lastName)) \(String(describing: lastName)) received.")
                        
                        let classID = document.get("classID") as! String?
                        
                        print("ClassID: \(String(describing: classID)) received.")
                        
                        let madeClassRequest = document.get("madeClassRequest") as! Bool?
                        
                        print("Setting user info...")
                        
                        if (classID != nil) {
                            self.currentUser!.updateClassID(newClassID: classID!)
                        }
                        
                        if (madeClassRequest == nil) {
                            print("Class Request Nil.")
                            self.currentUser!.updateMadeClassRequest(madeRequest: false)
                        } else {
                            print("Class Request: \(madeClassRequest!).")
                            self.currentUser!.updateMadeClassRequest(madeRequest: madeClassRequest!)
                        }
                        
                        if (firstName != nil || lastName != nil) {
                            self.currentUser!.updateName(newFirstName: firstName!, newLastName: lastName!)
                            self.newUser = false
                            self.session.updateSession(updatedUser: self.currentUser!)
                        } else {
                            self.newUser = true
                        }
                        
                        print("User info set.")
                        
                        self.loadingView = false
                    } else {
                        self.newUser = true
                        self.loadingView = false
                    }
                    
                }
            }
        )
    }
}
