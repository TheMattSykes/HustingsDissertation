//
//  ProvisionalList.swift
//  Hustings
//
//  Created by Matthew Sykes on 28/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import Foundation

struct ProvisionalList {
    
    private var topicA = PoliticalTopic(name: "How to vote", imageName: "link.circle")
    private var topicB = PoliticalTopic(name: "Parliament", imageName: "link.circle")
    
    func getProvisionalList() -> [PoliticalTopic] {
        return [topicA, topicB]
    }
}
