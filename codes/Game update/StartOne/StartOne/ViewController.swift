//
//  ViewController.swift
//  StartOne
//
//  Created by Cleaner on 1/24/15.
//  Copyright (c) 2015 Cleaner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblRound: UILabel!
    @IBOutlet weak var lblFirstNumber: UILabel!
    @IBOutlet weak var lblOperator: UILabel!
    @IBOutlet weak var lblSecondNumber: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    var game = Game()
    
    @IBAction func btnYES(sender: AnyObject) {
        userAnswer(true)
    }
    
    @IBAction func btnNO(sender: AnyObject) {
        userAnswer(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToSMSView" {
            var smsController = segue.destinationViewController as SMSViewController
            smsController.lblMessageText = game.score > 3 ? "You did it" : "You are dum"
        }
    }

    private func userAnswer(ansewer: Bool) {
        game.userAnswer(ansewer)
        if(game.round % 5 == 0 ){
            performSegueWithIdentifier("goToSMSView", sender: nil)
        }
        else {
            updateUI()
        }
    }
    
    private func updateUI(){
        lblRound.text = "Round: \(game.round)"
        lblScore.text = "Score: \(game.score)"
        lblFirstNumber.text = String(game.gameHelper.firstNumber)
        lblSecondNumber.text = String(game.gameHelper.seconNumber)
        lblOperator.text = String(game.gameHelper.operation!)
        lblAnswer.text = String(game.gameHelper.answer!)
    }

}

