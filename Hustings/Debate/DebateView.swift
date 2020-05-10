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
            
            // No class assigned to user
            if (currentState == .no_class) {
                Text("You need to join a class to take part in debates.")
            }
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
                
                if (self.currentUser!.getClassID() != nil) {
                    let docRef = self.db.collection("Classes").document(self.currentUser!.getClassID()!)
                     
                    docRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let ownerID = document.get("ownerID") as! String?
                            
                            if (ownerID == self.currentUser!.getUserID()!) {
                                self.currentState = .teacher_view
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
}

enum DebateState {
    case no_class
    case teacher_view
    case student_view
    case new
    case debate_list
    case view_messages
    case manage_debates
    case assign_sides
}
