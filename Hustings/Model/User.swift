//
//  User.swift
//  Hustings
//
//  Created by Matthew Sykes on 25/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import Foundation

/**
 User Model
 
 This class stores the information associated with a user.
 */
class User: ObservableObject, Identifiable {
    @Published var userID: String?
    @Published var email: String?
    @Published var displayName: String?
    @Published var firstName: String?
    @Published var lastName: String?
    @Published var classID: String?
    @Published var madeClassRequest: Bool
    @Published var side:Side?
    
    /**
     Returns the id of the user
     
     - returns: id as a String
     */
    func getUserID() -> String? {
        return userID ?? nil
    }
    
    /**
     Returns the full name of the user
     
     - returns: Optional string of user's full name
     */
    func getName() -> String? {
        if (firstName != nil && lastName != nil) {
            return (firstName! + " " + lastName!)
        } else {
            return nil
        }
    }
    
    /**
     Updates the full name of the user
     
     - parameter nameFirstName: First name of the user
     - parameter nameLastName: Last name of the user
     */
    func updateName(newFirstName: String, newLastName: String) {
        print("Updating name to \(newFirstName) \(newLastName)...")
        self.firstName = newFirstName
        self.lastName = newLastName
        
        print("Updated name to \(self.firstName ?? "NOT SET") \(self.lastName ?? "NOT SET")...")
    }
    
    /**
     Returns the class ID associated with the user
     
     - returns: Optional string of user's class ID
     */
    func getClassID() -> String? {
        return classID
    }
    
    /**
     Updates the class ID of the user
     
     - parameter nameClassID: Optional string of the new class ID
     */
    func updateClassID(newClassID: String?) {
        self.classID = newClassID
    }
    
    /**
     Returns a Bool denoting whether the user has requested to join a class
     
     - returns: Boolean: Whether a class request has been made
     */
    func getMadeClassRequest() -> Bool {
        return madeClassRequest
    }
    
    /**
     Updates the class ID of the user
     
     - parameter madeRequest: Boolean: Whether the user has requested to join a class
     */
    func updateMadeClassRequest(madeRequest: Bool) {
        self.madeClassRequest = madeRequest
    }
    
    /**
     Function to get the user's email address
     
     - returns: String of the user's email address
     */
    func getEmail() -> String {
        return email ?? "Error retrieving email."
    }
    
    /**
     Function to get side of debate user is on
     
     - returns: Side enum denoting user's side of debate
     */
    func getSide() -> Side? {
        return side
    }
    
    /**
     Updates the class ID of the user
     
     - parameter side: Boolean whether the user has requested to join a class
     */
    func setSide(side:Side) {
        self.side = side
    }
    
    /**
     Initialiser (When user selects 'Create Account' or profile is not set)
     */
    init(userID: String?, displayName: String?, email:String?) {
        self.userID = userID
        self.displayName = displayName
        self.email = email
        self.madeClassRequest = false
    }
    
    /**
     Initialiser (When user information exists or profile is updated)
     */
    init(userID: String?, displayName: String?, email:String?, firstName:String?, lastName:String?, classID:String?, classRequest: Bool) {
        self.userID = userID
        self.displayName = displayName
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.classID = classID
        self.madeClassRequest = classRequest
    }
}

/**
 Side
 
 Denotes which side of the debate a user is on.
 */
enum Side:String {
    case For
    case Against
    case Teacher
}
