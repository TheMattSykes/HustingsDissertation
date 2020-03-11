//
//  LoadTopics.swift
//  Hustings
//
//  Created by Matthew Sykes on 10/03/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore

struct LoadTopics {
    
    let db = Firestore.firestore()
    
    func loadTopics() -> [PoliticalTopic] {
        
        var topicList: [PoliticalTopic] = []
        
        db.collection("Topics").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error retrieving Topics")
            } else {
                for document in querySnapshot!.documents {
                    topicList.append(PoliticalTopic(name: document.get("name") as! String, imageName: document.get("imageName") as! String))
                }
            }
        }
        
        return topicList
    }
}
