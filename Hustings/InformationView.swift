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
    @State var prevButtonColor = Color.black
    @State var nextButtonColor = Color("HustingsGreen")
    @State var nextButtonText = "Next"
    
    @State var paragraphNo = 0 {
        didSet {
            if (paragraphNo <= 0) {
                prevButtonColor = .black
            } else {
                prevButtonColor = Color("HustingsGreen")
            }
            
            if (paragraphNo < topic.getTextData().count - 1) {
                nextButtonText = "Next"
            } else {
                nextButtonText = "Go to Quiz"
            }
        }
    }
    
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
            Text(topic.getTextData()[paragraphNo])
                .padding(20)
            Spacer()
            
            HStack(){
                Button(
                    action: {
                        if (self.paragraphNo > 0) {
                            self.paragraphNo -= 1
                        }
                    },
                    label: {
                        Text("Previous")
                            .fontWeight(.bold)
                    }
                ).fixedSize()
                    .frame(width: 100, height: 40)
                    .background(prevButtonColor)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .padding(20)
                
                Button(
                    action: {
                        if (self.paragraphNo < self.topic.getTextData().count - 1) {
                            self.paragraphNo += 1
                        }
                    },
                    label: {
                        Text(nextButtonText)
                            .fontWeight(.bold)
                    }
                ).fixedSize()
                    .frame(width: 100, height: 40)
                    .background(nextButtonColor)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .padding(20)
            }
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(topic: ProvisionalList().getProvisionalList()[0])
    }
}
