//
//  Message.swift
//  Hustings
//
//  Created by Matthew Sykes on 11/05/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation

/**
 Message Model
 
 Stores the data associated with a message.
 */
class Message: ObservableObject {
    var id:String
    private var user:String
    private var side:Side
    private var messageContent:String
    private var color:Color?
    
    /**
     Returns the name of the user who sent the message
     
     - returns: name as a String
     */
    func getUser() -> String {
        return user
    }
    
    /**
     Returns the side of the user who sent the message
     
     - returns: side as a String
     */
    func getSide() -> Side {
        return side
    }
    
    /**
     Returns the message text of the message
     
     - returns: side as a String
     */
    func getMessageContent() -> String {
        return messageContent
    }
    
    /**
     Returns the message colour depending on the side of the debate
     
     - returns: Color of the message background
     */
    func getColor() -> Color {
        if (side == .For) {
            return Color(red: 0.0, green: 200.0, blue: 0.0, opacity: 0.2)
        } else if (side == .Teacher) {
            return Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.2)
        } else {
            return Color(red: 200.0, green: 0.0, blue: 0.0, opacity: 0.2)
        }
    }
    
    init(id:String, user:String, side:Side, messageContent:String) {
        self.id = id
        self.user = user
        self.side = side
        self.messageContent = messageContent
    }
}
