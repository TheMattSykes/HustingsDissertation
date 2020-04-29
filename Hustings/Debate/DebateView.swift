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
import FirebaseDatabase
import FirebaseFirestore

struct DebateView: View {
    
    @EnvironmentObject var session: StoreSession
    @State var currentUser:User? = nil
    @State var currentState:DebateState = .empty
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

enum DebateState {
    case empty
    case new
    case viewMessages
    case manageDebates
    case assignSides
}
