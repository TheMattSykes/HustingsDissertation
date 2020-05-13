//
//  ClassProfileView.swift
//  Hustings
//
//  Created by Matthew Sykes on 12/04/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

/**
 View of class profile.
 
 Not implemented.
 */
struct ClassProfileView: View {
    
    @State var user:User
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Name: \(user.getName() ?? "Unable to retreive name.")")
            Text("Email: \(user.getEmail())")
        }.onAppear(
            perform: {
                
            }
        )
    }
}
