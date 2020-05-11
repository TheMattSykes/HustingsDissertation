//
//  TeacherViewScoresView.swift
//  Hustings
//
//  Created by Matthew Sykes on 11/05/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase

struct TeacherViewScoresView: View {
    @EnvironmentObject var session: StoreSession
    
    @State var user:User
    
    @State var scores:[Score] = [Score]()
    
    let db = Firestore.firestore()
    
    var body: some View {
        VStack {
            if (scores.count > 0) {
                List {
                    ForEach((self.scores), id: \.self.id) { score in
                        HStack {
                            Text(score.getName())
                            Spacer()
                            Text("\(score.getScore())")
                        }.padding(10)
                    }
                }
            } else {
                Text("You don't currently have any scores.")
            }
        }.onAppear(
            perform: {
                self.scores.removeAll()
                self.db.collection("Users/\(self.user.getUserID()!)/Results").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error retrieving Topics: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            self.scores.append(
                                Score(
                                    id: document.documentID,
                                    name: document.get("name") as! String,
                                    score: document.get("score") as! Int
                                )
                            )
                        }
                    }
                }
            }
        )
    }
}

