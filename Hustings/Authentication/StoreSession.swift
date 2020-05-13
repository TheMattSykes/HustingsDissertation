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
import Combine

/**
 Manages user account session.
 */
class StoreSession: ObservableObject {
    var objectWillChange = PassthroughSubject<StoreSession, Never>()
    var handle: AuthStateDidChangeListenerHandle?
    
    @Published var session: User? {
        didSet {
            print("Session being set.")
            self.objectWillChange.send(self)
        }
    }
    
    let db = Firestore.firestore() // database
    
    /**
     Get the user session
     
     - returns: User object
     */
    func getSession() -> User {
        return session!
    }
    
    /**
     Get the user session
     
     - parameter updatedUser: User object
     */
    func updateSession(updatedUser:User) {
        session = updatedUser
    }
    
    /**
     Check if user is currently logged in, checks session information.
     */
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
    
    /**
     Log into the user account using email and password.
     
     - parameter email: String of user email address.
     - parameter password: Password of user.
     - parameter handler: Session handler.
     */
    func logIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    /**
     Logs the user out
     
     - returns: Bool whether log out is successful
     */
    func logOut() -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
    
    /**
     Sign up for a new account.
     
     - parameter email: String of new user's email address.
     - parameter password: Password of new user.
     - parameter handler: Session handler.
     */
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    /**
     Reset the user's password.
     
     - parameter email: String of user's email address.
     - parameter handler: Session handler.
     */
    func resetPassword(email: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    /**
     Delete the user's account.
     */
    func deleteAccount() {
        Auth.auth().currentUser?.delete { (error) in
            if let error = error {
                print("An error occured while deleting the account: \(error)")
            } else {
                print("Account deleted!")
            }
        }
    }
    
    /**
     Unbind the session.
     */
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
