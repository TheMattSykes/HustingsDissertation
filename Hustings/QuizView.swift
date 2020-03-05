//
//  QuizView.swift
//  Hustings
//
//  Created by Matthew Sykes on 05/03/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

struct QuizView: View {
    
    @State var listOfQuestions = LoadQuestions().getQuestions()
    
    @State var standardPadding:CGFloat = 25
    @State var questionNo = 1
    @State var questionText = "The Houses of Parliament are comprised of the House of Commons and the House of _______."
    
    @State var correctQList:[Int] = []
    @State var incorrectQList:[Int] = []
    
    var body: some View {
        VStack {
            Text("Question \(questionNo)")
            .foregroundColor(Color("HustingsGreen"))
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("\(listOfQuestions[questionNo].questionText)")
                .padding(standardPadding)
            
            VStack(spacing: 5) {
                Button (
                    action: {
                        self.answerButton(isCorrect: true)
                    },
                    label: { Text("A").fontWeight(.bold) }
                )   .padding(standardPadding)
                    .background(Color("HustingsGreen"))
                    .foregroundColor(.white)
                
                Button (
                    action: {
                        self.answerButton(isCorrect: true)
                    },
                    label: { Text("B").fontWeight(.bold) }
                )   .padding(standardPadding)
                    .background(Color("HustingsGreen"))
                    .foregroundColor(.white)
                
                Button (
                    action: {
                        self.answerButton(isCorrect: true)
                    },
                    label: { Text("C").fontWeight(.bold) }
                )   .padding(standardPadding)
                    .background(Color("HustingsGreen"))
                    .foregroundColor(.white)
                
                Button (
                    action: {
                        self.answerButton(isCorrect: true)
                    },
                    label: { Text("D").fontWeight(.bold) }
                )   .padding(standardPadding)
                    .background(Color("HustingsGreen"))
                    .foregroundColor(.white)
            }
        }
    }
    
    func answerButton(isCorrect correct:Bool) {
        if (correct) {
            correctQList.append(questionNo)
        } else {
            correctQList.append(questionNo)
        }
        
        questionNo += 1
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
