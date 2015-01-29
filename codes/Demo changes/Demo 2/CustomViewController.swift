//
//  CustomViewController.swift
//  Demo
//
//  Created by Cleaner on 1/29/15.
//  Copyright (c) 2015 Oleh Sannikov. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    @IBOutlet weak var lblText: UILabel!
    
    var text: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblText.text = text
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
