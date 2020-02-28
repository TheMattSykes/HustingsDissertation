//
//  LearnMenuView.swift
//  Hustings
//
//  Created by Matthew Sykes on 27/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

struct Topic {
    
}

struct LearnMenuView: View {
    
    @State var topics:[PoliticalTopic] = ProvisionalList().getProvisionalList()
    
    var body: some View {
        NavigationView() {
            VStack {
                HStack {
                    Image(systemName: "link.circle")
                        .foregroundColor((Color("HustingsGreen")))
                        .font(.largeTitle)
                        // .fontWeight(.bold())
                    Text("Learn")
                        .font(.largeTitle)
                        .foregroundColor((Color("HustingsGreen")))
                }
//              List(topics) { topic in
                List {
                    NavigationLink(destination: TopicView()) {
                        HStack(spacing: 15) {
                            Image(systemName: topics[0].imageName)
                                .font(.title)
                            Text(topics[0].name)
                                .font(.title)
                        }.padding(20)
                    }
                }
            }.navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct LearnMenuView_Previews: PreviewProvider {
    static var previews: some View {
        LearnMenuView()
    }
}
