//
//  TestModel.swift
//  ProgrammingTestApp
//
//  Created by Cleaner on 2/4/15.
//  Copyright (c) 2015 Cleaner. All rights reserved.
//

import Foundation

class Test {
    var question: String
    var answers: [String]
    var correctIndex: Int
    
    init(q: String, a: [String], c: Int){
        self.question = q
        self.answers = a
        self.correctIndex = c
    }
    
    func isCorrect(userIndex: Int) -> Bool {
        return self.correctIndex == userIndex
    }
}
