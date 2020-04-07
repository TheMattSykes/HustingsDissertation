//
//  EmptyClassView.swift
//  Hustings
//
//  Created by Matthew Sykes on 07/04/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

struct EmptyClassView: View {
    
    @Binding var currentUser:User?
    @Binding var currentState:ClassState
    
    var body: some View {
        VStack(spacing: 15) {
            Button(
                action: {
                    
                },
                label: {
                   Text("Join Class")
                }
            )
                .fixedSize()
                .padding(10)
                .frame(width: 140, height: 50)
                .background(Color("HustingsGreen"))
                .foregroundColor(.white)
                .cornerRadius(15)
            
            Button(
                action: {
                    self.currentState = .new
                },
                label: {
                   Text("Create Class")
                }
            )
                .fixedSize()
                .padding(10)
                .frame(width: 140, height: 50)
                .background(Color("HustingsGreen"))
                .foregroundColor(.white)
                .cornerRadius(15)
        }
    }
}
