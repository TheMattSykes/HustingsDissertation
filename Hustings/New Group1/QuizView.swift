//
//  QuizView.swift
//  Hustings
//
//  Created by Matthew Sykes on 05/03/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore

struct QuizView: View {
    
    @State var topic:PoliticalTopic
    
    @State var listOfQuestions = [Question]()
    
    @State var standardPadding:CGFloat = 20
    @State var questionNo = 1
    
    @State var correctQList:[Int] = []
    @State var incorrectQList:[Int] = []
    
    let db = Firestore.firestore()
    
    var body: some View {
        VStack {
            if ((questionNo-1) < listOfQuestions.count) {
                Text("Question \(questionNo)")
                    .foregroundColor(Color("HustingsGreen"))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("\(listOfQuestions[questionNo-1].questionText)")
                    .padding(standardPadding)
                
                VStack(spacing: 15) {
                    ForEach((0..<self.listOfQuestions[questionNo-1].answers.count), id: \.self) { index in
                        Button (
                            action: {
                                self.answerButton(buttonNo: index)
                            },
                            label: { Text(self.listOfQuestions[self.questionNo-1].answers[index]).fontWeight(.bold) }
                        )
                            .fixedSize()
                            .padding(self.standardPadding)
                            .frame(width: 260, height: 50)
                            .background(Color("HustingsGreen"))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                }
            } else {
                Text("You scored \(correctQList.count)/\(listOfQuestions.count)")
            }
        }.onAppear(
            perform: { self.loadQuestions() }
        )
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
    
    func loadQuestions() {
        self.listOfQuestions.removeAll()
        self.db.collection("Topics/\(topic.getID())/Quiz").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error retrieving Topics: \(err)")
            } else {
                var qNo = 1
                for document in querySnapshot!.documents {
                    self.listOfQuestions.append(
                        Question(questionNo: qNo,
                                 questionText: document.get("question") as! String,
                                 answers: document.get("answers") as? [String] ?? [""],
                                 answer: document.get("correct") as! Int)
                    )
                    qNo += 1
                }
            }
        }
    }
}

//struct QuizView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizView()
//    }
//}
