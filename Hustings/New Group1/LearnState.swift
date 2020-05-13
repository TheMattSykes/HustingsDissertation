//
//  LearnState.swift
//  Hustings
//
//  Created by Matthew Sykes on 29/03/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

/**
 View to determine which view the system should use while in lesson mode.
 */
struct LearnState: View {
    
    @State var topic:PoliticalTopic
    @State var topicViewState = topicMode.information
    
    var body: some View {
        VStack{
            if (topicViewState == .information) {
                InformationView(topic: topic, topicViewState: $topicViewState)
            } else {
                QuizView(topic: topic)
            }
        }
    }
}

/**
 enum to determine current view.
 */
enum topicMode {
    case information
    case quiz
}
