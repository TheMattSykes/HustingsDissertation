//
//  ContentView.swift
//  Hustings
//
//  Created by Matthew Sykes on 24/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
// Image sources:
// GOV.uk
// https://pixabay.com/illustrations/vote-voting-voting-ballot-box-3569999/
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: StoreSession
    
    var body: some View {
        Group {
            if (session.session != nil) {
                PrimaryTabView()
            } else {
                LogInScreen()
            }
        }.onAppear(
            perform: {
                print("Preparing Session Listening...")
                self.session.listen()
                print("Session now listening.")
        }
        )
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
