//
//  LearnMenuView.swift
//  Hustings
//
//  Created by Matthew Sykes on 27/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

struct LearnMenuView: View {
    
    @State var topics:[PoliticalTopic] = []
    
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
                    ForEach(topics) { topic in
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
            }.navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle()).padding(0)
        }
        .onAppear(
            perform: { self.topics = LoadTopics().loadTopics() }
        )
    }
}

struct LearnMenuView_Previews: PreviewProvider {
    static var previews: some View {
         LearnMenuView()
    }
}
