//
//  DebateMessageViewTeacher.swift
//  Hustings
//
//  Created by Matthew Sykes on 11/05/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase

struct DebateMessageViewTeacher: View {
    @EnvironmentObject var session: StoreSession

    @State var currentUser:User? = nil
    @Binding var currentState:DebateState
    
    @State var debateName:String
    
    @State var messages:[Message] = [Message]()
    @State var messageList:[String] = [String]()
    @State var forSide:[String] = [String]()
    
    @State var myMessageContent = ""
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    let db = Firestore.firestore()
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                TextField("My Message", text: $myMessageContent)
                    .padding(20)
                    .frame(minWidth: 250, maxWidth: 250)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("HustingsGreen"), lineWidth: 2)
                    )
                
                Image(systemName: "paperplane.fill")
                    .fixedSize()
                    .padding(10)
                    .frame(width: 50, height: 50)
                    .background(Color("HustingsGreen"))
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            
            ScrollView() {
                VStack {
                    Text("John Bloggs")
                        .padding(5)
                    Text("sakldhkjdfhjkdhjdshajkhdasjkdhsjkahdjkhsajdhjksahdjsahdhjsakhdjshjkdahsjk")
                        .padding(5)
                }
                .padding(5)
                .background(Color(red: 0.0, green: 200.0, blue: 0.0, opacity: 0.4))
                
                VStack {
                    Text("John Bloggs")
                        .padding(5)
                    Text("sakldhkjdfhjkdhjdshajkhdasjkdhsjkahdjkhsajdhjksahdjsahdhjsakhdjshjkdahsjk")
                        .padding(5)
                }
                .padding(5)
                .background(Color(red: 0.0, green: 200.0, blue: 0.0, opacity: 0.4))
                
                VStack {
                    Text("John Bloggs")
                        .padding(5)
                    Text("sakldhkjdfhjkdhjdshajkhdasjkdhsjkahdjkhsajdhjksahdjsahdhjsakhdjshjkdahsjk")
                        .padding(5)
                }
                .padding(5)
                .background(Color(red: 0.0, green: 200.0, blue: 0.0, opacity: 0.4))
                
                VStack {
                    Text("John Bloggs")
                        .padding(5)
                    Text("sakldhkjdfhjkdhjdshajkhdasjkdhsjkahdjkhsajdhjksahdjsahdhjsakhdjshjkdahsjk")
                        .padding(5)
                }
                .padding(5)
                .background(Color(red: 0.0, green: 200.0, blue: 0.0, opacity: 0.4))
            }.frame(minHeight: 200, maxHeight: 250)
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
                
                self.messages.removeAll()
                self.forSide.removeAll()
                
                let docRef = self.db.collection("Classes/\(self.currentUser!.getClassID()!)/Debates").document(self.debateName)
                
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        self.messageList = document.get("messages") as? [String] ?? [""]
                        self.forSide = document.get("messages") as? [String] ?? [""]
                    } else {
                        print("Error locating debate content")
                    }
                }
            }
        )
    }
}
