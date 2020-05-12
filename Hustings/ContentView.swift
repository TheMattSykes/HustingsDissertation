//
//  ContentView.swift
//  Hustings
//
//  Created by Matthew Sykes on 24/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: StoreSession
    @State var passwordReset = false
    @State var newUser = true
    @State var loadingView = true
    
    var body: some View {
        Group {
            if (session.session != nil) {
                if (!loadingView && !newUser) {
                    PrimaryTabView()
                } else {
                    if (loadingView) {
                        LoadProfileView(loadingView: $loadingView, newUser: $newUser)
                    } else {
                        NewUserInfo(newUser: $newUser, loadingView: $loadingView)
                    }
                }
            } else {
                if (!passwordReset) {
                    LogInScreen(passwordReset: $passwordReset, loadingView: $loadingView)
                } else {
                    ResetPasswordScreen(passwordReset: $passwordReset)
                }
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
