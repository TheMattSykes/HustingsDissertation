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
    @State var textData = [String]()
    
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
                        NavigationLink(destination: LearnState(topic: topic)) {
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
//            .navigationViewStyle(StackNavigationViewStyle()).padding(0)
        }.onAppear(
            perform: { self.loadTopics() }
        )
    }
    
    func loadTopics() {
        self.topics.removeAll()
        self.db.collection("Topics").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error retrieving Topics: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let docName = document.get("name") as! String
                    self.topics.append(
                        PoliticalTopic(
                            id: document.documentID,
                            name: docName,
                            imageName: document.get("image_name") as! String,
                            textData: document["paragraphs"] as? [String] ?? [""],
                            quiz: nil)
                    )
                }
            }
        }
    }
    
    
//    func getTextData() {
//        for topic in topics {
//            print("CHECKING TOPICS...")
//            self.db.collection("Topics/\(topic.getID())/Learn_Text").getDocuments() { (querySnapshot, err) in
//                if let err = err {
//                    print("Error retrieving Topics: \(err)")
//                } else {
//                    self.textData = self.extractTextInfo(doc: querySnapshot!.documents[0])
//                }
//            }
//        }
//    }
//
//    func extractTextInfo(doc:QueryDocumentSnapshot) -> [String] {
//        print("EXTRACT FUNCTION REACHED")
//        var textArray = [String]()
//
//        let dict = doc.data()
//
//        if let products = dict["products"] as? [AnyHashable: Any] {
//            for (_,value) in products {
//                textArray.append(value as! String)
//
//                print(value as! String)
//            }
//        }
//
//        return textArray
//    }
    
    
}

struct LearnMenuView_Previews: PreviewProvider {
    static var previews: some View {
         LearnMenuView()
    }
}

