//
//  ClassView.swift
//  Hustings
//
//  Created by Matthew Sykes on 27/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

struct ClassView: View {
    
    @EnvironmentObject var session: StoreSession
    @State var currentUser:User? = nil
    @State var currentState:ClassState = .empty
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Image(systemName: "person.3.fill")
                    .foregroundColor((Color("HustingsGreen")))
                    .font(.largeTitle)
                Text("Class")
                    .foregroundColor((Color("HustingsGreen")))
                    .font(.largeTitle)
            }
            
            if (self.currentState == .empty) {
                EmptyClassView(currentUser: $currentUser, currentState: $currentState)
            }
            
            if (self.currentState == .new) {
                NewClassView(currentState: $currentState)
            }
            
            if (self.currentState == .join) {
                Text("Join mode")
            }
            
            if (self.currentState == .main_teacher) {
                Text("Currently joined to class")
            }
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
                
                if (self.currentUser?.getClassID() == nil) {
                    self.currentState = .empty
                }
            }
        )
    }
}

enum ClassState {
    case empty
    case new
    case join
    case main_student
    case main_teacher
}
