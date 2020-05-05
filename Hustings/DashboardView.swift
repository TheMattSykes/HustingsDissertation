//
//  DashboardView.swift
//  Hustings
//
//  Created by Matthew Sykes on 15/04/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore

struct DashboardView: View {
    @EnvironmentObject var session: StoreSession
    @State var currentUser:User? = nil
    
    @State var scores:[Score] = [Score]()
    
    let db = Firestore.firestore()
    
    @State var navBarHidden = true
    
    @State var numberOfTopics:Int = 0
    @State var progress:Int = 0
    @State var progressFloat: CGFloat = 0.0
    
    var body: some View {
        NavigationView() {
            VStack(spacing: 25) {
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor((Color("HustingsGreen")))
                        .font(.largeTitle)
                    Text("Dashboard")
                        .foregroundColor((Color("HustingsGreen")))
                        .font(.largeTitle)
                }
                
                Text("My Progress")
                    .foregroundColor((Color("HustingsGreen")))
                    .font(.title)
                
                ZStack {
                    Circle()
                        .stroke(Color.gray, lineWidth: 15)
                    Circle()
                        .trim(from: 0, to: progressFloat)
                        .stroke(Color("HustingsGreen"), lineWidth: 15)
                        .rotationEffect(.degrees(-90))
                    Text("\(progress)%")
                        .font(.largeTitle)
                        .foregroundColor(Color("HustingsGreen"))
                }.frame(width: 180, height: 180, alignment: .center)
                
                NavigationLink(destination: QuizResultsView(scores: scores, navBarHidden: $navBarHidden)) {
                    Text("My Results")
                        .fixedSize()
                        .padding(10)
                        .frame(width: 150, height: 50)
                        .background(Color("HustingsGreen"))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
            }
            .navigationBarHidden(navBarHidden)
            .navigationBarTitle(Text(""))
//            .edgesIgnoringSafeArea([.top, .bottom])
        }.onAppear(
            perform: {
                self.currentUser = self.session.getSession()
                
                self.navBarHidden = true
                
                self.loadScores()
            }
        )
    }
    
    func loadScores() {
        self.scores.removeAll()
        self.db.collection("Users/\(self.currentUser!.getUserID()!)/Results").getDocuments() { (querySnapshot, err) in
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
                
                self.calculateNumberOfTopics()
            }
        }
    }
    
    func calculateNumberOfTopics() {
        self.numberOfTopics = 0
        
        self.db.collection("Topics").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error retrieving Topics: \(err)")
            } else {
                for _ in querySnapshot!.documents {
                    self.numberOfTopics += 1
                }
                
                self.calculateProgress()
            }
        }
    }
    
    func calculateProgress() {
        self.progressFloat = CGFloat(self.scores.count / self.numberOfTopics)
        self.progress = Int(self.progressFloat * 100)
    }
}
