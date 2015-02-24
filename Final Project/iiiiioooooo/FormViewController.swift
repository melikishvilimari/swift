//
//  FormViewController.swift
//  iiiiioooooo
//
//  Created by Cleaner on 2/10/15.
//  Copyright (c) 2015 Cleaner. All rights reserved.
//

import UIKit
import MobileCoreServices
import AssetsLibrary
import CoreLocation


protocol FormViewControllerDelegate {
    func formControllerDidFinish(controller:FormViewController, model:FormModel)
}

class FormViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var delegate: FormViewControllerDelegate?
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDesc: UITextView!
    var model: FormModel = FormModel()
    let picker = UIImagePickerController()
    
    
    
    
    @IBAction func shootPhoto(sender: UIBarButtonItem) {
        picker.delegate = self
        picker.allowsEditing = false
        //picker.sourceType = UIImagePickerControllerSourceType.Camera
        //picker.cameraCaptureMode = .Photo
        picker.mediaTypes = [kUTTypeImage]
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func photoFromLibrary(sender: UIBarButtonItem) {
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func btnSave(sender: AnyObject) {
        if (delegate != nil) {
            model.Name = txtName.text
            model.Desc = txtDesc.text
            delegate!.formControllerDidFinish(self, model: model)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if picker.sourceType == UIImagePickerControllerSourceType.PhotoLibrary {
            println("come")
            let image = info[UIImagePickerControllerOriginalImage] as UIImage
            let library = ALAssetsLibrary()
            var url: NSURL = info[UIImagePickerControllerReferenceURL] as NSURL
            println(url)
            library.assetForURL(url, resultBlock: { (asset: ALAsset!) -> Void in
                if asset.valueForProperty(ALAssetPropertyLocation) != nil {
                    var lat = (asset.valueForProperty(ALAssetPropertyLocation) as CLLocation!).coordinate.latitude
                    var lng = (asset.valueForProperty(ALAssetPropertyLocation) as CLLocation!).coordinate.longitude
                    self.model.Ltd = "\(lat)"
                    self.model.Lng = "\(lng)"
                }
                else {
                    println("no location")
                }
                
                }, failureBlock: { (error: NSError!) in println("error")
            })
        }
        
        var chosenImage = info[UIImagePickerControllerOriginalImage] as UIImage
        
        
        let fileManager = NSFileManager.defaultManager()
        var imageData: NSData = UIImagePNGRepresentation(chosenImage)
        let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let imageName = "\(NSDate()).png"
        let path = documents.stringByAppendingPathComponent(imageName)
        //data.writeToFile(path, atomically: true)
        
        fileManager.createFileAtPath(path, contents: imageData, attributes: nil)
        
        model.Image = imageName
        
        println(path)
        println(imageName)
        //image = chosenImage
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: path)!)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
