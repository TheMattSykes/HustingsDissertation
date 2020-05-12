//
//  Question.swift
//  Hustings
//
//  Created by Matthew Sykes on 05/03/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import Foundation

/**
 Question
 
 Model for storing data associated with a question.
 */
struct Question: Identifiable {
    var id:String = UUID().uuidString
    var questionNo:Int
    var questionText:String
    var answers:[String]
    var answer:Int
    
    init(questionNo:Int, questionText:String, answers:[String], answer:Int) {
        self.questionNo = questionNo
        self.questionText = questionText
        self.answers = answers
        self.answer = answer
    }
}
