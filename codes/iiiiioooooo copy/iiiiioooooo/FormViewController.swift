//
//  FormViewController.swift
//  iiiiioooooo
//
//  Created by Cleaner on 2/10/15.
//  Copyright (c) 2015 Cleaner. All rights reserved.
//

import UIKit

protocol FormViewControllerDelegate {
    func formControllerDidFinish(controller:FormViewController, model:FormModel)
}

class FormViewController: UIViewController {
    var delegate: FormViewControllerDelegate?
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtSurname: UITextField!
    
    @IBAction func btnSave(sender: AnyObject) {
        if (delegate != nil) {
            delegate!.formControllerDidFinish(self, model: FormModel(name: txtName.text, surname: txtSurname.text))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
