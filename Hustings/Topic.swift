//
//  Topic.swift
//  Hustings
//
//  Created by Matthew Sykes on 28/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import Foundation

struct PoliticalTopic: Identifiable {
    var id:String = UUID().uuidString
    var name:String
    var imageName:String
    var textData:[String]?
    var quiz:[Question]?
    
    func getName() -> String {
        return name
    }
    
    init(name:String, imageName:String) {
        self.name = name
        self.imageName = imageName
        self.textData = nil
        self.quiz = nil
    }
    
    init(name:String, imageName:String, textData:[String], quiz:[Question]) {
        self.name = name
        self.imageName = imageName
        self.textData = textData
        self.quiz = quiz
    }
}


