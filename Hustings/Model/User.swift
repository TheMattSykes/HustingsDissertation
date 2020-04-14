//
//  User.swift
//  Hustings
//
//  Created by Matthew Sykes on 25/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import Foundation

class User: ObservableObject, Identifiable {
    @Published var userID: String?
    @Published var email: String?
    @Published var displayName: String?
    @Published var firstName: String?
    @Published var lastName: String?
    @Published var classID: String?
    @Published var madeClassRequest: Bool
    
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
    
    func updateName(newFirstName: String, newLastName: String) {
        print("Updating name to \(newFirstName) \(newLastName)...")
        self.firstName = newFirstName
        self.lastName = newLastName
        
        print("Updated name to \(self.firstName ?? "NOT SET") \(self.lastName ?? "NOT SET")...")
    }
    
    func getClassID() -> String? {
        return classID
    }
    
    func updateClassID(newClassID: String) {
        self.classID = newClassID
    }
    
    func getMadeClassRequest() -> Bool {
        return madeClassRequest
    }
    
    func updateMadeClassRequest(madeRequest: Bool) {
        self.madeClassRequest = madeRequest
    }
    
    func getEmail() -> String {
        return email ?? "Error retrieving email."
    }
    
    init(userID: String?, displayName: String?, email:String?) {
        self.userID = userID
        self.displayName = displayName
        self.email = email
        self.madeClassRequest = false
    }
    
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
