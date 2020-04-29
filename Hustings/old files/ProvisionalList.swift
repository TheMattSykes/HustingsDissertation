//
//  ProvisionalList.swift
//  Hustings
//
//  Created by Matthew Sykes on 28/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import Foundation

struct ProvisionalList {
    
    private var topicA = PoliticalTopic(id: "How_To_Vote", name: "How to vote", imageName: "ballotbox-square")
    private var topicB = PoliticalTopic(id: "Parliament", name: "Parliament", imageName: "parliament-exterior-square")
    
    func getProvisionalList() -> [PoliticalTopic] {
        return [topicA, topicB]
    }
}
