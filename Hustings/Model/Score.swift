//
//  Score.swift
//  Hustings
//
//  Created by Matthew Sykes on 02/05/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import Foundation

class Score: ObservableObject {
    var id:String
    private var name:String
    private var score:Int
    
    /**
     Returns the id of the topic associated with a score
     
     - returns: id as a String
     */
    func getID() -> String {
        return id
    }
    
    /**
     Returns the name of the topic associated with a score
     
     - returns: Topic name as a String
     */
    func getName() -> String {
        return name
    }
    
    /**
     Returns the quiz score associated with a topic
     
     - returns: Score as an Int
     */
    func getScore() -> Int {
        return score
    }
    
    /**
     Constructor
     
     - parameter name: Name of the topic as a String
     - parameter score: Quiz score as an Int
     */
    init(id:String, name:String, score:Int) {
        self.id = id
        self.name = name
        self.score = score
    }
}
