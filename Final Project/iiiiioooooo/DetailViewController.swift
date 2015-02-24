//
//  DetailViewController.swift
//  iiiiioooooo
//
//  Created by Cleaner on 2/10/15.
//  Copyright (c) 2015 Cleaner. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var lblName: UILabel!


    var detailItem: AnyObject? {
        didSet {
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let lbldesc = self.detailDescriptionLabel {
                if let lblname = self.lblName {
                    var name: String = detail.valueForKey("name")!.description
                    var desc: String = detail.valueForKey("desc")!.description
                    var imageURL: String = detail.valueForKey("image")!.description
                    println(imageURL)
                    /*detail.setValue(model.Image, forKey: "image")
                    detail.setValue(model.Name, forKey: "name")
                    detail.setValue(model.Desc, forKey: "desc")
                    detail.setValue(model.Lng, forKey: "Lng")
                    detail.setValue(model.Ltd, forKey: "Lat")*/
                    
                    lblname.text = name
                    lbldesc.text = desc
                    self.view.backgroundColor = UIColor(patternImage: UIImage(named: imageURL)!)
                }
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

