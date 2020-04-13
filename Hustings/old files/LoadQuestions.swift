//
//  LoadQuestions.swift
//  Hustings
//
//  Created by Matthew Sykes on 05/03/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import Foundation

struct LoadQuestions {
    // var questionList:[Question] = []
    
    func getQuestions() -> [Question] {
        
        var question1 = Question(questionNo: 1, questionText: "After the 2019 General Election, which party forms the largest Opposition?", answers: ["Conservatives","Labour","Liberal Democrats","Scottish National Party"], answer: 1)
        
        var question2 = Question(questionNo: 2, questionText: "Who is the current Prime Minister?", answers: ["Boris Johnson","Theresa May","Vince Cable","Count Binface"], answer: 0)
        
        var question3 = Question(questionNo: 3, questionText: "What year is the next election as it currently stands?", answers: ["2021","2022","2023","2024"], answer: 3)
        
        return [question1, question2, question3]
    }
}
