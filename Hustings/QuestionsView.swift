////
////  QuestionsView.swift
////  Hustings
////
////  Created by Matthew Sykes on 06/03/2020.
////  Copyright © 2020 Matthew Sykes. All rights reserved.
////
//
//import SwiftUI
//
//struct QuestionsView: View {
//
//    var listOfQuestions:[Question]
//    var correctQList:[Int]
//    var incorrectQList:[Int]
//
//    @State var questionNo:Int = 1
//    @State var standardPadding = 20
//
//    var body: some View {
//        VStack {
//            Text("Question \(questionNo)")
//                .foregroundColor(Color("HustingsGreen"))
//                .font(.largeTitle)
//                .fontWeight(.bold)
//            Text("\(listOfQuestions[questionNo-1].questionText)")
//                .padding(standardPadding)
//
//            VStack(spacing: 10) {
//                Button (
//                    action: {
//                        self.answerButton(buttonNo: 0)
//                },
//                    label: { Text(listOfQuestions[questionNo-1].answers[0]).fontWeight(.bold) }
//                )
//                    .fixedSize()
//                    .padding(standardPadding)
//                    .frame(width: 280, height: 75)
//                    .background(Color("HustingsGreen"))
//                    .foregroundColor(.white)
//                    .cornerRadius(15)
//
//                Button (
//                    action: {
//                        self.answerButton(buttonNo: 1)
//                },
//                    label: { Text(listOfQuestions[questionNo-1].answers[1]).fontWeight(.bold) }
//                )
//                    .fixedSize()
//                    .padding(standardPadding)
//                    .frame(width: 280, height: 75)
//                    .background(Color("HustingsGreen"))
//                    .foregroundColor(.white)
//                    .cornerRadius(15)
//
//                Button (
//                    action: {
//                        self.answerButton(buttonNo: 2)
//                },
//                    label: { Text(listOfQuestions[questionNo-1].answers[2]).fontWeight(.bold) }
//                )
//                    .fixedSize()
//                    .padding(standardPadding)
//                    .frame(width: 280, height: 75)
//                    .background(Color("HustingsGreen"))
//                    .foregroundColor(.white)
//                    .cornerRadius(15)
//
//                Button (
//                    action: {
//                        self.answerButton(buttonNo: 3)
//                },
//                    label: { Text(listOfQuestions[questionNo-1].answers[3]).fontWeight(.bold) }
//                )
//                    .fixedSize()
//                    .padding(standardPadding)
//                    .frame(width: 280, height: 75)
//                    .background(Color("HustingsGreen"))
//                    .foregroundColor(.white)
//                    .cornerRadius(15)
//            }
//        }
//    }
//
//    func answerButton(buttonNo:Int) {
//        let correct = (buttonNo == listOfQuestions[questionNo-1].answer)
//
//        if (correct) {
//            correctQList.append(questionNo-1)
//        } else {
//            incorrectQList.append(questionNo-1)
//        }
//
//        questionNo += 1
//    }
//}
//
//
//struct QuestionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionsView()
//    }
//}
