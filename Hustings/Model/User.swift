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
    
    func getName() -> String {
        return displayName ?? "Error retrieving name."
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
