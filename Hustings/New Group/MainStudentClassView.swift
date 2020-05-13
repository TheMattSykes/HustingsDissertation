//
//  MainStudentClassView.swift
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
 Primary view for students inside a class.
 */
struct MainStudentClassView: View {
    @EnvironmentObject var session: StoreSession
    
    @Binding var currentState:ClassState
    
    @State var currentUser:User? = nil
    
    @State var userIDs:[String] = [String]()
    @State var users:[User] = [User]()
    
    @State var teacherName:String? = nil
    
    @State private var showingAlert = false
    
    let db = Firestore.firestore()
    
    var body: some View {
        VStack(spacing: 15) {
            Text("ClassID: \(currentUser?.getClassID() ?? "Error retreiving class name")")
            Text("Teacher: \(teacherName ?? "Error retreiving teacher name")")
            Text("Joined to class as: Student")
            
            Button(
                action: {
                    self.showingAlert = true
                },
                label: {
                   Text("Leave Class")
                }
            ).alert(isPresented: $showingAlert) {
                Alert(title: Text("Leave Class"), message: Text("Are you sure you want to leave this class?"), primaryButton: .destructive(Text("Leave")) {
                        self.leaveClass()
                    }, secondaryButton: .cancel())
            }
                .fixedSize()
                .padding(10)
                .frame(width: 140, height: 50)
            .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(15)
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
                
                self.getTeacherInfo()
            }
        )
    }
    
    /**
     Get teacher name from database.
     */
    func getTeacherInfo() {
        let classDocRef = self.db.collection("Classes").document(self.currentUser!.getClassID()!)
         
        classDocRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let ownerID = document.get("ownerID") as! String?
                
                let teacherDocRef = self.db.collection("Users").document(ownerID!)
                
                print("ownerID: \(ownerID!)    teacherDocRef: \(teacherDocRef)")
                
                teacherDocRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        print("document exists")
                        let firstName = document.get("firstName") as! String?
                        let lastName = document.get("lastName") as! String?
                        
                        if (firstName != nil && lastName != nil) {
                            self.teacherName = firstName! + " " + lastName!
                            print("teacher name found: \(firstName!) \(lastName!)")
                        }
                    }
                }
            }
        }
    }
    
    /**
     Leave the current class.
     */
    func leaveClass() {
        let userID = self.currentUser!.getUserID()!
        let classID = self.currentUser!.getClassID()!
        
        let classDocRef = self.db.collection("Classes").document(classID)
        let userDocRef = self.db.collection("Users").document(userID)
        
        classDocRef.updateData([
            "members": FieldValue.arrayRemove([userID])
        ])
        
        userDocRef.updateData([
            "classID": FieldValue.delete()
        ])
        
        self.currentUser!.updateClassID(newClassID: nil)
        session.updateSession(updatedUser: self.currentUser!)
        
        currentState = .empty
    }
}
