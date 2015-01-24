// Playground - noun: a place where people can play

import UIKit

import Foundation

class Game {
    
    class GameHelper {
        
        
        let firstNumber: Int
        let seconNumber: Int
        var operation: Character?
        var answer: Int?
        var realOrFake: Int?
        
        init(){
            self.firstNumber = Int(arc4random_uniform(100))
            self.seconNumber = Int(arc4random_uniform(100))
            self.operation = getOperationCharacter()
            deside()
        }
        
        private func getOperationCharacter() -> Character {
            var num = Int(arc4random_uniform(4))
            switch(num){
            case 0:
                self.answer = firstNumber - seconNumber
                return "-"
            case 1:
                self.answer = firstNumber + seconNumber
                return "+"
            default:
                self.answer = firstNumber * seconNumber
                return "*"
            }
        }
        
        private func deside(){
            var rand = Int(arc4random_uniform(2))
            realOrFake = rand == 0 ? answer! - 2 : answer!
        }
        
        func isRealOrFakeEqualsAnswer() -> Bool {
            return answer == realOrFake
        }
        
    }
    
    
    var score: Int = 0
    var round: Int = 0
    var gameHelper: GameHelper = GameHelper()
    
    private func nextRound(){
        gameHelper = GameHelper()
        round++;
    }
    
    func userAnswer(ans: Bool) {
        score = gameHelper.isRealOrFakeEqualsAnswer() ? score + 1 : score;
        nextRound()
    }
}

var game = Game()
game.gameHelper.firstNumber
game.gameHelper.seconNumber
game.gameHelper.operation!
game.gameHelper.realOrFake!
game.gameHelper.answer!



