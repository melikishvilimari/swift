//
//  ViewController.swift
//  ProgrammingTestApp
//
//  Created by Cleaner on 2/4/15.
//  Copyright (c) 2015 Cleaner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func btnStartTest() {
        performSegueWithIdentifier("startTest", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "startTest"){
            var controller = segue.destinationViewController as TestController
        }
    }

}

