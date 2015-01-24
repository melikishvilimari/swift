//
//  ViewController.swift
//  StartOne
//
//  Created by Cleaner on 1/24/15.
//  Copyright (c) 2015 Cleaner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblRoundCounter: UILabel!
    @IBOutlet weak var lblScoreCounter: UILabel!
    @IBOutlet weak var lblFirstNumber: UILabel!
    @IBOutlet weak var lblSecondNumber: UILabel!
    @IBOutlet weak var lblOperation: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    var game = Game()
    
    @IBAction func btnYes(sender: AnyObject) {
        game.userAnswer(true)
    }
    
    @IBAction func btnNo(sender: AnyObject) {
        game.userAnswer(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func updateUI(){
        lblRoundCounter.text = String(game.round)
        lblScoreCounter.text = String(game.score)
        lblFirstNumber.text = String(game.gameHelper.firstNumber)
        lblSecondNumber.text = String(game.gameHelper.seconNumber)
        lblOperation.text = String(game.gameHelper.operation!)
    }

}

