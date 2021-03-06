//
//  TestController.swift
//  ProgrammingTestApp
//
//  Created by Cleaner on 2/4/15.
//  Copyright (c) 2015 Cleaner. All rights reserved.
//

import UIKit

class TestController: UIViewController, UIAlertViewDelegate {

    var testManager = TestManager(round: 4)
    @IBOutlet weak var lblTestCounter: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var btnA: UIButton!
    @IBOutlet weak var btnB: UIButton!
    @IBOutlet weak var tbnC: UIButton!
    @IBOutlet weak var btnD: UIButton!
    
    @IBAction func btnAClick(sender: AnyObject) {
        getNextTest(0)
    }
    
    @IBAction func btnBClick(sender: AnyObject) {
        getNextTest(1)
    }
    
    @IBAction func btnCClick(sender: AnyObject) {
        getNextTest(2)
    }
    
    @IBAction func btnDClick(sender: AnyObject) {
        getNextTest(3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func getNextTest(userIndex: Int){
        testManager.userAnswer(userIndex)
        if(testManager.round != testManager.currentTestIndex) {
            updateUI()
        }
        else {
            let alertView = UIAlertController(title: "Your score is", message: "\(testManager.score) from \(testManager.round)", preferredStyle: .Alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {
                (action: UIAlertAction!) -> Void in
                    self.testManager = TestManager(round: 4)
                    self.updateUI()
            }))
            presentViewController(alertView, animated: true, completion: nil)
        }
    }
    
    private func updateUI(){
        btnA.setTitle(testManager.getCurrent().answers[0], forState: UIControlState.Normal)
        btnB.setTitle(testManager.getCurrent().answers[1], forState: UIControlState.Normal)
        tbnC.setTitle(testManager.getCurrent().answers[2], forState: UIControlState.Normal)
        btnD.setTitle(testManager.getCurrent().answers[3], forState: UIControlState.Normal)
        lblQuestion.text = testManager.getCurrent().question
        lblTestCounter.text = "\(testManager.currentTestIndex + 1)/\(testManager.round)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
