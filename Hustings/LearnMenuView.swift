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
                    ForEach(topics) { topic in
                        NavigationLink(destination: TopicView()) {
                            HStack(spacing: 15) {
//                                Image(systemName: topic.imageName)
//                                    .font(.title)
                                Image(topic.imageName)
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width:100, height:100)
                                    .overlay(Circle().stroke(Color("HustingsGreen"), lineWidth: 3))
                                Text(topic.name)
                                    .font(.title)
                            }.padding(5)
                        }
                    }
                }
            }.navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct LearnMenuView_Previews: PreviewProvider {
    static var previews: some View {
        LearnMenuView()
    }
}
