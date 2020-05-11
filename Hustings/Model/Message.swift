//
//  Message.swift
//  Hustings
//
//  Created by Matthew Sykes on 11/05/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import Foundation

struct Message {
    private var user:String
    private var side:Side
    private var messageContent:String
    
    func getUser() -> String {
        return user
    }
    
    func getSide() -> Side {
        return side
    }
    
    func getMessageContent() -> String {
        return messageContent
    }
}
