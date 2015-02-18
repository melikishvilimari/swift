//
//  FormViewController.swift
//  iiiiioooooo
//
//  Created by Cleaner on 2/10/15.
//  Copyright (c) 2015 Cleaner. All rights reserved.
//

import UIKit
import MobileCoreServices
protocol FormViewControllerDelegate {
    func formControllerDidFinish(controller:FormViewController, model:FormModel)
}

class FormViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var delegate: FormViewControllerDelegate?
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtSurname: UITextField!
    var image: UIImage?
    //@IBOutlet var view: UIView!
    //@IBOutlet weak var imageView: UIImageView!
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
            delegate!.formControllerDidFinish(self, model: FormModel(name: txtName.text, surname: txtSurname.text, image: image!))
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
    

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as UIImage //2
        //imageView.contentMode = .ScaleAspectFit //3
        //imageView.image = chosenImage //4
        image = chosenImage
        self.view.backgroundColor = UIColor(patternImage: chosenImage)
        dismissViewControllerAnimated(true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
