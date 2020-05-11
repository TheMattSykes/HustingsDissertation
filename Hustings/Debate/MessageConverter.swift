//
//  MessageConverter.swift
//  Hustings
//
//  Created by Matthew Sykes on 11/05/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import Foundation

class MessageConverter {
    func convertMessages(messageList:[String]) -> [Message] {
        var num:Int = 0
        
        var messages = [Message]()
        
        if (messageList.count > 0) {
            for message in messageList {
                let contents = message.components(separatedBy: "|")
                
                num += 1
                
                if (contents.count >= 3) {
                    messages.append(
                        Message(
                            id: String(num), user: contents[0], side: Side(rawValue: contents[1]) ?? .For, messageContent: contents[2]
                        )
                    )
                }
            }
            
            messages.reverse()
        }
        
        return messages
    }
}
