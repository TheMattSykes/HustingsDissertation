//
//  MainStudentDebateView.swift
//  Hustings
//
//  Created by Matthew Sykes on 10/05/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

/**
 Default view for students.
 */
struct MainStudentDebateView: View {
    
    @EnvironmentObject var session: StoreSession
    @State var currentUser:User? = nil
    @Binding var currentState:DebateState
    
    var body: some View {
        VStack(spacing: 15) {
            Button (
                action: {
                    self.currentState = .debate_list_student
                },
                label: {
                    Text("My Debates")
                }
            )
            .fixedSize()
            .padding(10)
            .frame(width: 180, height: 50)
            .background(Color("HustingsGreen"))
            .foregroundColor(.white)
            .cornerRadius(15)
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
            }
        )
    }
}
