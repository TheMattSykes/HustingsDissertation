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

/**
 View when inside a debate for teachers.
 */
struct DebateMessageViewTeacher: View {
    @EnvironmentObject var session: StoreSession

    @State var currentUser:User? = nil
    @Binding var currentState:DebateState
    
    @State var debateName:String
    
    @State var question:String = ""
    
    @State var messageConverter = MessageConverter()
    @State var messages:[Message] = [Message]()
    @State var messageList:[String] = [String]()
    @State var forSide:[String] = [String]()
    @State var isTeacher = true
    @State var messageColor:Color? = nil
    
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
                
                Button(
                    action: {
                        self.writeMessageToDatabase()
                    },
                    
                    label: { Image(systemName: "paperplane.fill") }
                )
                    .fixedSize()
                    .padding(10)
                    .frame(width: 50, height: 50)
                    .background(Color("HustingsGreen"))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                
                Button(
                    action: {
                        self.reloadData()
                    },
                    
                    label: { Image(systemName: "arrow.counterclockwise") }
                )
                    .fixedSize()
                    .padding(10)
                    .frame(width: 50, height: 50)
                    .background(Color("HustingsGreen"))
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            
            Text("Question: \(question)")
            
            List {
                ForEach((self.messages), id: \.self.id) { message in
                    VStack {
                        Text(message.getUser())
                            .padding(5)
                        Text(message.getMessageContent())
                            .padding(5)
                    }
                        .frame(maxWidth: .infinity)
                        .background(message.getColor())
                        .padding(5)
                }.onDelete(perform: delete) // when user swipes to delete
            }
                .frame(minHeight: 200)
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
                
                self.reloadData()
            }
        )
    }
    
    /**
     Delete a message.
     */
    func delete(at offsets: IndexSet) {
        guard let index = Array(offsets).first else {
            return
        }
        
        messages.remove(at: index)
        
        messages.reverse()
        
        var newMessagesList = [String]()
        
        for message in messages {
            let name = message.getUser()
            let side = message.getSide()
            let message = message.getMessageContent()
            
            let processedMessage = name + "|" + side.rawValue + "|" + message
            
            newMessagesList.append(processedMessage)
        }
        
        let docRef = self.db.collection("Classes/\(self.currentUser!.getClassID()!)/Debates").document(self.debateName)
        
        // Push to database
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                docRef.updateData([
                    "messages": newMessagesList
                ])
                
                self.reloadData()
            } else {
                self.showingAlert = true
                self.alertTitle = "Unable to update message debate data"
                self.alertMessage = "An error occured."
            }
        }
    }
    
    /**
     Write a new message and format for storage in database.
     */
    func writeMessageToDatabase() {
        let name = self.currentUser!.getName()!
        let side = "Teacher"
        
        let processedMessage = name + "|" + side + "|" + self.myMessageContent
        
        let docRef = self.db.collection("Classes/\(self.currentUser!.getClassID()!)/Debates").document(self.debateName)
        
        // Push to database
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                docRef.updateData([
                    "messages": FieldValue.arrayUnion([processedMessage])
                ])
                
                self.myMessageContent = ""
                
                self.reloadData()
            } else {
                self.showingAlert = true
                self.alertTitle = "Unable to locate debate data"
                self.alertMessage = "Please try again later."
            }
        }
    }
    
    /**
     Download database information.
     */
    func reloadData() {
        self.messages.removeAll()
        self.forSide.removeAll()
        
        let docRef = self.db.collection("Classes/\(self.currentUser!.getClassID()!)/Debates").document(self.debateName)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.messageList = document.get("messages") as? [String] ?? [""]
                self.forSide = document.get("for") as? [String] ?? [""]
                self.question = document.get("topic") as? String ?? ""
                
                self.messages = self.messageConverter.convertMessages(messageList: self.messageList)
            } else {
                print("Error locating debate content")
            }
        }
    }
}
