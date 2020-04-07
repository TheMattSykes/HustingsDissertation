//
//  User.swift
//  Hustings
//
//  Created by Matthew Sykes on 25/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import Foundation

struct User {
    var userID: String?
    var email: String?
    var displayName: String?
    var firstName: String?
    var lastName: String?
    var classID: String?
    
    func getUserID() -> String? {
        return userID ?? nil
    }
    
    func getName() -> String? {
        print("!!! GETTING NAME \(String(describing: firstName)) \(String(describing: lastName))")
        
        if (firstName != nil && lastName != nil) {
            return (firstName! + " " + lastName!)
        } else {
            return nil
        }
    }
    
    mutating func updateName(newFirstName: String, newLastName: String) {
        print("Updating name to \(newFirstName) \(newLastName)...")
        self.firstName = newFirstName
        self.lastName = newLastName
        
        print("Updated name to \(self.firstName ?? "NOT SET") \(self.lastName ?? "NOT SET")...")
    }
    
    func getClassID() -> String? {
        return classID
    }
    
    mutating func updateClassID(newClassID: String) {
        self.classID = newClassID
    }
    
    func getEmail() -> String {
        return email ?? "Error retrieving email."
    }
    
    init(userID: String?, displayName: String?, email:String?) {
        self.userID = userID
        self.displayName = displayName
        self.email = email
    }
}
