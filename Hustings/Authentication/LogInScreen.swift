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
    
    @Binding var passwordReset:Bool
    @Binding var loadingView:Bool
    
    @State private var email = ""
    @State private var password = ""
    @State private var err = false
    @State private var load = false
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 10) {
            Image("HustingsLogoGreen")
                .resizable()
                .scaledToFit()
                .frame(minWidth: 0, maxWidth: 250)
                .padding(20)
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(20)
                .frame(minWidth: 250, maxWidth: 350)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("HustingsGreen"), lineWidth: 2)
                )
            SecureField("Password", text: $password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(20)
                .frame(minWidth: 250, maxWidth: 350)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("HustingsGreen"), lineWidth: 2)
                )
            
            HStack(spacing: 5) {
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
                                print("Error occured while logging in. \(error)")
                                self.err = true
                                
                                self.showingAlert = true
                                self.alertTitle = "Sign in Error"
                                self.alertMessage = "Please check your email and password are correct."
                            }
                        }
                    },
                    label: {
                       Text("Sign in")
                    }
                ).alert(isPresented: $showingAlert) {
                    Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
                }
                    .fixedSize()
                    .padding(10)
                    .frame(width: 140, height: 50)
                    .background(Color("HustingsGreen"))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                
                Button(
                    action: {
                        print("Attempting to sign up...")
                        self.err = false
                        self.load = true
                        
                        self.session.signUp(email: self.email, password: self.password) { (result, error) in
                            self.load = false
                            
                            // If no errors present
                            if error == nil {
                                self.email = ""
                                self.password = ""
                            } else {
                                print("Error occured while signing up.") // debug
                                self.err = true
                                
                                self.showingAlert = true
                                self.alertTitle = "New Account Error"
                                self.alertMessage = "An error occured while creating a new account."
                            }
                        }
                    },
                    label: {
                       Text("Create Account")
                    }
                )
                    .fixedSize()
                    .padding(10)
                    .frame(width: 140, height: 50)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            
            Button(
                action: {
                    self.passwordReset = true
                },
                label: {
                   Text("Reset Password")
                }
            )
                .fixedSize()
                .padding(10)
                .frame(width: 140, height: 50)
                .background(Color.white)
                .foregroundColor(Color.blue)
                .cornerRadius(15)
            }.onAppear(
                perform: { self.loadingView = true }
            )
            .padding(10)
    }
}


