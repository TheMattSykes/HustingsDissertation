//
//  InformationView.swift
//  Hustings
//
//  Created by Matthew Sykes on 06/03/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

struct InformationView: View {
    
    @State var topic:PoliticalTopic
//    @State var progressBarValue:CGFloat = 0
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Spacer()
                Image(topic.imageName)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width:60, height:60)
                    .overlay(Circle().stroke(Color("HustingsGreen"), lineWidth: 3))
                Text(topic.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("HustingsGreen"))
                Spacer()
            }
            Spacer()
            Button(
                action: {
                    
                },
                label: {
                    Text("Next")
                        .fontWeight(.bold)
                }
            ).fixedSize()
                .frame(width: 100, height: 40)
                .background(Color("HustingsGreen"))
                .foregroundColor(.white)
                .cornerRadius(15)
                .padding(20)
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(topic: ProvisionalList().getProvisionalList()[0])
    }
}
