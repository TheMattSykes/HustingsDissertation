//
//  LogInScreen.swift
//  Hustings
//
//  Created by Matthew Sykes on 25/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

struct LogInScreen: View {
    
    @EnvironmentObject var session: StoreSession
    
    @State private var email = ""
    @State private var password = ""
    @State private var err = false
    @State private var load = false
    
    var body: some View {
        VStack {
            Image("HustingsLogoGreen")
                .resizable()
                .scaledToFit()
                .frame(minWidth: 0, maxWidth: 250)
                .padding(20)
            
            TextField("Email", text: $email)
                .padding()
                .border(Color("HustingsGreen"), width: 2)
            SecureField("Password", text: $password)
                .padding()
                .border(Color("HustingsGreen"), width: 2)
            
            if (err) {
                Text("")
            }
            
            GeometryReader { geometry in
                Button(
                    action: {
                        print("Attempting to log in...")
                        self.err = false
                        self.load = true
                        
                        self.session.logIn(email: self.email, password: self.password) { (result, error) in
                            self.load = false
                            
                            if error == nil {
                                print("Logged in with no errors.")
                                self.email = ""
                                self.password = ""
                            } else {
                                print("Error occured while logging in.")
                                self.err = true
                            }
                        }
                    },
                    label: {
                       Text("Sign in")
                    }
                )
            }
        }
    }
}

//struct LogInScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        LogInScreen()
//    }
//}
