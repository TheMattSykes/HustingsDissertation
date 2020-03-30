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
    
    init(userID: String?, displayName: String?, email:String?) {
        self.userID = userID
        self.displayName = displayName
        self.email = email
    }
}
