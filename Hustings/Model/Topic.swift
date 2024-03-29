//
//  Topic.swift
//  Hustings
//
//  Created by Matthew Sykes on 28/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import Foundation

/**
 PoliticalTopic
 
 Model for storing data associated with a political topic.
 */
class PoliticalTopic: ObservableObject {
    @Published var id:String
    @Published var name:String
    @Published var imageName:String
    @Published var textData:[String]?
    @Published var quiz:[Question]?
    
    /**
     Returns the id of the topic
     
     - returns: id as a String
     */
    func getID() -> String {
        return id
    }
    
    /**
     Returns the name of the topic
     
     - returns: name as a String
     */
    func getName() -> String {
        return name
    }
    
    /**
     Returns the text data of the topic
     
     - returns: text data (paragraphs) as a String array
     */
    func getTextData() -> [String] {
        return textData!
    }
    
    init(id:String, name:String, imageName:String) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.textData = nil
        self.quiz = nil
    }
    
    init(id:String, name:String, imageName:String, textData:[String]?, quiz:[Question]?) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.textData = textData
        self.quiz = quiz
    }
}


