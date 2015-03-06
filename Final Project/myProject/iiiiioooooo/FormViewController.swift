import UIKit
import MobileCoreServices
import AssetsLibrary
import CoreLocation

class FormViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var timePicker: UIPickerView!
    
    var delegate: FormViewControllerDelegate?
    var model: FormModel = FormModel()
    let picker = UIImagePickerController()
    
    let recipeCategoryPicker = ["dinner", "drink", "desert"]
    var pickedCategory: String?
    var pickedTime: String = "1"
    
    @IBAction func shootPhoto(sender: UIBarButtonItem) {
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.cameraCaptureMode = .Photo
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
            model.Minute = "\(pickedTime)"
            model.Category = pickedCategory
            delegate!.formControllerDidFinish(self, model: model)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickedCategory = recipeCategoryPicker[0]
        
        picker.delegate = self
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        
        timePicker.dataSource = self
        timePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 0) {
            return recipeCategoryPicker.count
        }
        return 120
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if(pickerView.tag == 0) {
            return recipeCategoryPicker[row]
        }
        return "\(row + 1)"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 0) {
            pickedCategory = recipeCategoryPicker[row]
        }
        else {
            pickedTime = "\(row + 1)"
        }
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var titleData = "\(row + 1)"
        if(pickerView.tag == 0) {
            titleData = recipeCategoryPicker[row]
        }
        var myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!, NSForegroundColorAttributeName:UIColor.whiteColor()])
        return myTitle
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        if picker.sourceType == UIImagePickerControllerSourceType.PhotoLibrary {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            let library = ALAssetsLibrary()
            var url: NSURL = info[UIImagePickerControllerReferenceURL] as! NSURL
            library.assetForURL(url, resultBlock: { (asset: ALAsset!) -> Void in
                if asset.valueForProperty(ALAssetPropertyLocation) != nil {
                    var lat = (asset.valueForProperty(ALAssetPropertyLocation) as! CLLocation!).coordinate.latitude
                    var lng = (asset.valueForProperty(ALAssetPropertyLocation) as! CLLocation!).coordinate.longitude
                    self.model.Ltd = "\(lat)"
                    self.model.Lng = "\(lng)"
                }
                else {
                    println("no location")
                }
                
                }, failureBlock: { (error: NSError!) in println("error")
            })
        }
        
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let fileManager = NSFileManager.defaultManager()
        var imageData: NSData = UIImagePNGRepresentation(chosenImage)
        let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let imageName = "\(NSDate()).png"
        let path = documents.stringByAppendingPathComponent(imageName)
        fileManager.createFileAtPath(path, contents: imageData, attributes: nil)
        model.Image = imageName
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: path)!)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
