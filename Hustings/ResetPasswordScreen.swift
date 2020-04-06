//
//  ResetPasswordScreen.swift
//  Hustings
//
//  Created by Matthew Sykes on 06/04/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

struct ResetPasswordScreen: View {
    
    @EnvironmentObject var session: StoreSession
    
    @Binding var passwordReset:Bool
    
    @State private var email = ""
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
                .padding(20)
                .frame(minWidth: 250, maxWidth: 350)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("HustingsGreen"), lineWidth: 2)
                )
            
            if (err) {
                Text("")
            }
            
            Button(
                action: {
                    print("Attempting to reset password...")
                     self.err = false
                     self.load = true
                     
                     self.session.resetPassword(email: self.email) { (result, error) in
                         self.load = false
                         
                         if error == nil {
                            print("Reset password with no errors.")
                            self.email = ""
                            
                            self.showingAlert = true
                            self.alertTitle = "Password Reset"
                            self.alertMessage = "A link has been sent to the email provided."
                            
                         } else {
                            print("Error occured while resetting password.")
                            self.err = true
                            
                            self.showingAlert = true
                            self.alertTitle = "Password Reset Error"
                            self.alertMessage = "An error occured while resetting your password. Please ensure your email is already registered."
                         }
                     }
                },
                label: {
                   Text("Send Link")
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
                    self.passwordReset = false
                },
                label: {
                   Text("Back")
                }
            )
                .fixedSize()
                .padding(10)
                .frame(width: 140, height: 50)
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(15)
        }.padding(10)
    }
}
