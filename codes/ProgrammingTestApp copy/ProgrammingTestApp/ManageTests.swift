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
    
    init() {
        tests =
        [
            Test(q: "What is swift?", a: ["programming language", "bird", "car", "twitter"], c: 0),
            Test(q: "question 2", a: ["A", "b", "c", "d"], c: 0),
            Test(q: "question 3", a: ["A", "b", "c", "d"], c: 0),
            Test(q: "question 4", a: ["A", "b", "c", "d"], c: 0)
        ]
        
        currentTestIndex = 0
        score = 0
    }
    
    func userAnswer(userIndex: Int) {
        score = getCurrent().isCorrect(userIndex) ? score + 1 : score;
        currentTestIndex++;
    }
    
    func getCurrent() -> Test {
        return tests[currentTestIndex]
    }
}