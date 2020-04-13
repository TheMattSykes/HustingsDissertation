//
//  StoreSession.swift
//  Hustings
//
//  Created by Matthew Sykes on 30/03/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore
import Combine

class StoreSession: ObservableObject {
    var objectWillChange = PassthroughSubject<StoreSession, Never>()
    var handle: AuthStateDidChangeListenerHandle?
    
    @Published var session: User? {
        didSet {
            print("Session being set.")
            self.objectWillChange.send(self)
        }
    }
    
    let db = Firestore.firestore()
    
    func getSession() -> User {
        return session!
    }
    
    func updateSession(updatedUser:User) {
        session = updatedUser
    }
    
    func listen() {
        print("Listen request recieved.")
        handle = Auth.auth().addStateDidChangeListener { [unowned self] (auth, user) in
            if let user = user {
                print("Session is set.")
                self.session = User(userID: user.uid, displayName: user.displayName, email: user.email)
            } else {
                print("Session is nil.")
                self.session = nil
            }
        }
    }
    
    func logIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func logOut() -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func resetPassword(email: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
