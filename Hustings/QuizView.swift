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
    
    @State var correctQList:[Int] = []
    @State var incorrectQList:[Int] = []
    
    var body: some View {
        VStack {
            if ((questionNo-1) < listOfQuestions.count) {
                Text("Question \(questionNo)")
                    .foregroundColor(Color("HustingsGreen"))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("\(listOfQuestions[questionNo-1].questionText)")
                    .padding(standardPadding)
                
                VStack(spacing: 10) {
                    Button (
                        action: {
                            self.answerButton(buttonNo: 0)
                    },
                        label: { Text(listOfQuestions[questionNo-1].answers[0]).fontWeight(.bold) }
                    )
                        .fixedSize()
                        .padding(standardPadding)
                        .frame(width: 280, height: 75)
                        .background(Color("HustingsGreen"))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    
                    Button (
                        action: {
                            self.answerButton(buttonNo: 1)
                    },
                        label: { Text(listOfQuestions[questionNo-1].answers[1]).fontWeight(.bold) }
                    )
                        .fixedSize()
                        .padding(standardPadding)
                        .frame(width: 280, height: 75)
                        .background(Color("HustingsGreen"))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    
                    Button (
                        action: {
                            self.answerButton(buttonNo: 2)
                    },
                        label: { Text(listOfQuestions[questionNo-1].answers[2]).fontWeight(.bold) }
                    )
                        .fixedSize()
                        .padding(standardPadding)
                        .frame(width: 280, height: 75)
                        .background(Color("HustingsGreen"))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    
                    Button (
                        action: {
                            self.answerButton(buttonNo: 3)
                    },
                        label: { Text(listOfQuestions[questionNo-1].answers[3]).fontWeight(.bold) }
                    )
                        .fixedSize()
                        .padding(standardPadding)
                        .frame(width: 280, height: 75)
                        .background(Color("HustingsGreen"))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
            } else {
                Text("You scored \(correctQList.count)/\(listOfQuestions.count)")
            }
        }
    }
    
    func answerButton(buttonNo:Int) {
        let correct = (buttonNo == listOfQuestions[questionNo-1].answer)
        
        if (correct) {
            correctQList.append(questionNo-1)
        } else {
            incorrectQList.append(questionNo-1)
        }
        
        questionNo += 1
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
