//
//  LoadTopics.swift
//  Hustings
//
//  Created by Matthew Sykes on 10/03/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import Foundation
import Firebase
//import FirebaseDatabase
//import FirebaseFirestore

class LoadTopics {
    
//    let db = Firestore.firestore()
//    
//    var topicsComplete = false
//    
//    func loadTopics() -> [PoliticalTopic] {
//        
//        var listOfTopics: [PoliticalTopic] = []
//        
//        db.collection("Topics").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error retrieving Topics: \(err)")
//                self.topicsComplete = true
//            } else {
//                // print("STARTING FOR")
//                for document in querySnapshot!.documents {
//                    // print("INSIDE FOR")
//                    listOfTopics.append(PoliticalTopic(name: document.get("name") as! String, imageName: document.get("image_name") as! String))
//                    // print("Current topicList count: \(listOfTopics.count)")
//                }
//                self.topicsComplete = true
//            }
//        }
//        
//        return listOfTopics
//    }
}
