//
//  DetailViewController.swift
//  iiiiioooooo
//
//  Created by Cleaner on 2/10/15.
//  Copyright (c) 2015 Cleaner. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //@IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    //@IBOutlet weak var imageView: UIImageView!
   // @IBOutlet var view: UIView!
    

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let label = self.detailDescriptionLabel {
                var name: String = detail.valueForKey("name")!.description
                var surname: String = detail.valueForKey("surname")!.description
                label.text = "\(name) \(surname)"
                //self.imageView.image = UIImage(data: detail.valueForKey("photo")! as NSData)
                self.view.backgroundColor = UIColor(patternImage: UIImage(data: detail.valueForKey("photo")! as NSData)!)
                //println(detail.valueForKey("photo")!.description)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

