//
//  LearnMenuView.swift
//  Hustings
//
//  Created by Matthew Sykes on 27/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore

struct LearnMenuView: View {
    
    @State var topics = [PoliticalTopic]()
    
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationView() {
            VStack {
                HStack {
                    Image(systemName: "link.circle")
                        .foregroundColor((Color("HustingsGreen")))
                        .font(.largeTitle)
                    Text("Learn")
                        .font(.largeTitle)
                        .foregroundColor((Color("HustingsGreen")))
                }
                List {
                    ForEach((self.topics), id: \.self.id) { topic in
                        NavigationLink(destination: InformationView(topic: topic)) {
                            HStack(spacing: 15) {
                                Image(topic.imageName)
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width:60, height:60)
                                    .overlay(Circle().stroke(Color("HustingsGreen"), lineWidth: 3))
                                Text(topic.name)
                                    .font(.title)
                            }.padding(5)
                        }
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle()).padding(0)
        }.onAppear(
            perform: { self.loadTopics() }
        )
    }
    
    func loadTopics() {
        
//        var listOfTopics: [PoliticalTopic] = []
        self.topics.removeAll()
        self.db.collection("Topics").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error retrieving Topics: \(err)")
            } else {
                // print("STARTING FOR")
                for document in querySnapshot!.documents {
                    // print("INSIDE FOR")
                    self.topics.append(PoliticalTopic(name: document.get("name") as! String, imageName: document.get("image_name") as! String))
                    // print("Current topicList count: \(listOfTopics.count)")
                }
            }
        }
    }
}

struct LearnMenuView_Previews: PreviewProvider {
    static var previews: some View {
         LearnMenuView()
    }
}
