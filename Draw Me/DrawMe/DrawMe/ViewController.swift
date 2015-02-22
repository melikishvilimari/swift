//
//  ViewController.swift
//  DrawMe
//
//  Created by Admin on 2/22/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorSlider: UISlider!
    @IBOutlet weak var brushWidth: UISlider!
    @IBOutlet weak var customView: DrawView!
    @IBOutlet weak var saveViewImage: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func lineWidthSlider(sender: AnyObject) {
        customView.lineWidth = brushWidth.value
        customView.setNeedsDisplay()
    }

   
    @IBAction func saveAsImage(sender: UIBarButtonItem) {
        UIGraphicsBeginImageContextWithOptions(customView.bounds.size, false, 0.0)
        customView.drawViewHierarchyInRect(customView.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let data = UIImagePNGRepresentation(image)
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(data, forKey: "snapshot")
        userDefaults.synchronize()
        println(image.size)
        let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let path = documents.stringByAppendingPathComponent("test.png")
        data.writeToFile(path, options: .DataWritingAtomic, error: nil)
        //self.view.backgroundColor = UIColor(patternImage: image)
        println("saved on " + path)
    }
    
    @IBAction func clearView(sender: UIBarButtonItem) {
        colorSlider.value = 0
        brushWidth.value = 0
        customView.lines = []
        customView.setNeedsDisplay()
    }
    @IBAction func colorChangeSlider(sender: AnyObject) {
        println(colorSlider.value)
        var sliderValue = CGFloat(colorSlider.value)
        customView.color = UIColor(hue: sliderValue, saturation: 1, brightness: 1, alpha: 1)
        customView.setNeedsDisplay()

    }
}

