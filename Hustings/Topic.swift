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
    
    init(name:String, imageName:String) {
        self.name = name
        self.imageName = imageName
    }
}


