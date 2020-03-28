//
//  Topic.swift
//  Hustings
//
//  Created by Matthew Sykes on 28/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import Foundation

class PoliticalTopic: ObservableObject {
    @Published var id:String
    @Published var name:String
    @Published var imageName:String
    @Published var textData:[String]?
    @Published var quiz:[Question]?
    
    func getID() -> String {
        return id
    }
    
    func getName() -> String {
        return name
    }
    
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


