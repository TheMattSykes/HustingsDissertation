//
//  RequestMadeView.swift
//  Hustings
//
//  Created by Matthew Sykes on 14/04/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase
//import FirebaseDatabase
//import FirebaseFirestore

/**
 Student view when requested to join a new class.
 */
struct RequestMadeView: View {
    
    @EnvironmentObject var session: StoreSession
    
    @Binding var currentUser:User?
    
    @Binding var currentState:ClassState
    
    let db = Firestore.firestore()
    
    var body: some View {
        VStack(spacing: 15) {
            Text("You have requested to join a class.")
            
            Button(
                action: {
                    self.cancelRequest()
                },
                label: {
                    Text("Cancel Request")
                }
            ).fixedSize()
            .padding(10)
            .frame(width: 180, height: 50)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(15)
        }
    }
    
    /**
     Cancel request to join a class.
     */
    func cancelRequest() {
        let docRef = self.db.collection("Users").document(currentUser!.getUserID()!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let requestedClassID = document.get("requestedClassID") as! String?
                
                if (requestedClassID != nil) {
                    self.updateCancelData(classID: requestedClassID!)
                } else {
                    self.db.collection("Users").document(self.currentUser!.getUserID()!).updateData([
                        "madeClassRequest": false,
                        "requestedClassID": FieldValue.delete()
                    ])
                }
                
            } else {
                print("Error retreiving member user information.")
            }
        }
    }
    
    /**
     Update database.
     */
    func updateCancelData(classID: String) {
        let classDocRef = self.db.collection("Classes").document(classID)
        let userDocRef = self.db.collection("Users").document(currentUser!.getUserID()!)
        
        classDocRef.updateData([
            "requests": FieldValue.arrayRemove([currentUser!.getUserID()!])
        ])
        
        userDocRef.updateData([
            "madeClassRequest": false,
            "requestedClassID": FieldValue.delete()
        ])
        
        currentState = .empty
    }
}
