//
//  DetailsViewController.swift
//  Demo
//
//  Created by Oleh Sannikov on 26.01.15.
//  Copyright (c) 2015 Oleh Sannikov. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView?
    var image: UIImage?

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        imageView?.image = image
    }
    @IBAction func doSomeWorkForMe(sender: AnyObject) {
        performSegueWithIdentifier("goToWelcome", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToWelcome" {
            var welcome = segue.destinationViewController as CustomViewController
            welcome.text = "from details"
        }
    }
    
}
