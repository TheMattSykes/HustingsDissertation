//
//  DebateListTeacherView.swift
//  Hustings
//
//  Created by Matthew Sykes on 11/05/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase

/**
 View to list the current debates.
 */
struct DebateListTeacherView: View {
    @EnvironmentObject var session: StoreSession

    @State var currentUser:User? = nil
    @Binding var currentState:DebateState
    
    @State var debateList = [String]()
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    let db = Firestore.firestore()
    
    var body: some View {
        VStack {
            if (debateList.count > 0) {
                NavigationView {
                    List {
                        ForEach((self.debateList), id: \.self) { debate in
                            NavigationLink(destination: DebateMessageViewTeacher(currentState: self.$currentState, debateName: debate)) {
                                HStack {
                                    Text(debate)
                                }.padding(10)
                            }
                        }.onDelete(perform: delete) // when user swipes to delete
                    }
                }
            } else {
                Text("There aren't any debates available.")
            }
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
                
                self.debateList.removeAll()
                self.db.collection("Classes/\(self.currentUser!.getClassID()!)/Debates").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error retrieving debates: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            self.debateList.append(document.documentID)
                        }
                    }
                }
            }
        )
    }
    
    /**
     Delete a debate.
     */
    func delete(at offsets: IndexSet) {
        guard let index = Array(offsets).first else {
            return
        }
        
        let debateName = debateList[index]
        
        debateList.remove(at: index)
        
        self.db.collection("Classes/\(self.currentUser!.getClassID()!)/Debates").document(debateName).delete()
    }
}

