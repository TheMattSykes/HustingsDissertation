//
//  MainTeacherClassView.swift
//  Hustings
//
//  Created by Matthew Sykes on 10/04/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase

/**
 Default view for teachers when accessing the class view.
 */
struct MainTeacherClassView: View {
    @EnvironmentObject var session: StoreSession
    
    @Binding var currentState:ClassState
    
    @State var currentUser:User? = nil
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @State private var showingDeleteAlert = false
    
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationView() {
            VStack(spacing: 15) {
                Text("ClassID: \(currentUser?.getClassID() ?? "Error retreiving class name!")")
                NavigationLink(destination: UserListTeacherClassView()) {
                    Text("Class Members")
                    .fixedSize()
                    .padding(10)
                    .frame(width: 180, height: 50)
                    .background(Color("HustingsGreen"))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                }
                
                NavigationLink(destination: RequestsView()) {
                    Text("Member Requests")
                    .fixedSize()
                    .padding(10)
                    .frame(width: 180, height: 50)
                    .background(Color("HustingsGreen"))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                }
                
                Button(
                    action: {
                        self.showingDeleteAlert = true
                    },
                    label: {
                       Text("Delete Class")
                    }
                ).alert(isPresented: $showingDeleteAlert) {
                    Alert(title: Text("Delete Class"), message: Text("Are you sure you want to delete your class? Your debates will not be deleted. Please make sure you delete your debates first."), primaryButton: .destructive(Text("Delete")) {
                            self.deleteClass()
                        }, secondaryButton: .cancel())
                }
                    
                .fixedSize()
                .padding(10)
                .frame(width: 180, height: 50)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(15)
            }
        }
        .navigationBarHidden(true)
        .onAppear(
            perform: {
                self.currentUser = self.session.getSession()
            }
        )
    }
    
    /**
     Delete the class.
     */
    func deleteClass() {
        self.db.collection("Classes").document(self.currentUser!.getClassID()!).delete()
    }
}
