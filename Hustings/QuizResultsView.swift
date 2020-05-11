//
//  QuizResultsView.swift
//  Hustings
//
//  Created by Matthew Sykes on 02/05/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase


struct QuizResultsView: View {
    @EnvironmentObject var session: StoreSession
    
    @State var scores:[Score]
    
    @Binding var navBarHidden:Bool
    
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
                self.navBarHidden = false
            }
        )
        .navigationBarTitle(Text("My Results"))
    }
}
