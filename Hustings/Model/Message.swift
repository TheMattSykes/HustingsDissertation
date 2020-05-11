//
//  Message.swift
//  Hustings
//
//  Created by Matthew Sykes on 11/05/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation

class Message: ObservableObject {
    var id:String
    private var user:String
    private var side:Side
    private var messageContent:String
    private var color:Color?
    
    func getUser() -> String {
        return user
    }
    
    func getSide() -> Side {
        return side
    }
    
    func getMessageContent() -> String {
        return messageContent
    }
    
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
