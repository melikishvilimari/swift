//
//  ManageTests.swift
//  ProgrammingTestApp
//
//  Created by Cleaner on 2/4/15.
//  Copyright (c) 2015 Cleaner. All rights reserved.
//

import Foundation

class TestManager {
    var tests: [Test]
    var currentTestIndex: Int
    var score: Int
    var round: Int
    
    init(round: Int) {
        tests =
        [
            Test(q: "What is swift?", a: ["programming language", "bird", "car", "twitter"], c: 0),
            Test(q: "Which of the following is an 8-byte Integer?", a: ["Char", "Long", "Short", "Byte"], c: 0),
            Test(q: "Which of the following statements is correct about Managed Code?", a: ["Managed code is the code", "It provides a language-neutral", "The resources are garbage", "applications"], c: 0),
            Test(q: "It provides a consistent object-oriented programming environment whether object code is stored and executed locally, executed locally but Internet-distributed, or executed remotely", a: ["A", "B", "C", "D"], c: 0)
        ]
        
        currentTestIndex = 0
        score = 0
        self.round = round
    }
    
    func userAnswer(userIndex: Int) {
        score = getCurrent().isCorrect(userIndex) ? score + 1 : score;
        currentTestIndex++;
    }
    
    func getCurrent() -> Test {
        return tests[currentTestIndex]
    }
}