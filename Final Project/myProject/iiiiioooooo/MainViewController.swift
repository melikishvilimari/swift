import UIKit
import CoreData

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, FormViewControllerDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var data: [MainTable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        self.myCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func reloadData() {
        let fetchRequest = NSFetchRequest(entityName: "MainTable")
        let sortDescriptor = NSSortDescriptor(key: "image", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let fetchResults = context!.executeFetchRequest(fetchRequest, error: nil) as? [MainTable] {
            data = fetchResults
        }
    }
    
    func formControllerDidFinish(controller:FormViewController, model:FormModel){
        if let lat = model.Ltd {
            self.data.insert(MainTable.createInManagedObjectContext(context!, desc: model.Desc!, image: model.Image!, lat: model.Ltd!, lng: model.Lng!, name: model.Name!, minute: model.Minute!, category: model.Category!), atIndex: 0)
        }
        else {
            self.data.insert(MainTable.createInManagedObjectContext(context!, desc: model.Desc!, image: model.Image!, lat: nil, lng: nil, name: model.Name!, minute: model.Minute!, category: model.Category!), atIndex: 0)
        }
        
        
        self.search.text = ""
        self.myCollectionView.reloadData()
        
        var error: NSError? = nil
        if !context!.save(&error) {
            println(error?.localizedDescription)
            abort()
        }
        controller.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "details" {
            var c = segue.destinationViewController as! DetailViewController
            c.detail = data[sender as! Int]
        }
        else if segue.identifier == "createNewItem" {
            var c = segue.destinationViewController as! FormViewController
            c.delegate = self
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("customCell", forIndexPath: indexPath) as! MyCollectionViewCell
        let name: String = data[indexPath.row].name
        let imageURL: String = data[indexPath.row].image
        let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let path = documents.stringByAppendingPathComponent(imageURL)
        cell.imageView.image = UIImage(named: path)
        cell.minuteLabel.text = "\(data[indexPath.row].minute) min"
        cell.recipeName.text = name
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("goToDetails:"))
        cell.imageView.tag = indexPath.row
        cell.imageView.addGestureRecognizer(tap)
        cell.imageView.userInteractionEnabled = true
        
        let tapTap = UITapGestureRecognizer(target: self, action: Selector("delteItem:"))
        tapTap.numberOfTapsRequired = 2
        cell.recipeName.tag = indexPath.row
        cell.recipeName.addGestureRecognizer(tapTap)
        cell.recipeName.userInteractionEnabled = true
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
            return CGSize(width: self.view.frame.width / 2, height: self.view.frame.width / 2)
    }
    
    func goToDetails(sender: UITapGestureRecognizer){
        self.view.endEditing(true);
        performSegueWithIdentifier("details", sender: sender.view!.tag)
    }
    
    func delteItem(sender: UITapGestureRecognizer){
        
        let alertView = UIAlertController(title: "Delete \(data[sender.view!.tag].name)", message: "", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (alertAction) -> Void in
            let item = self.data[sender.view!.tag]
            self.data.removeAtIndex(sender.view!.tag)
            self.context?.deleteObject(item)
            self.context!.save(nil)
            self.myCollectionView.reloadData()
        }))
        alertView.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alertView, animated: true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject!) -> Bool {
        return true
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if(count(searchText) == 0) {
            self.view.endEditing(true);
        }
        reloadData()
        data = count(searchText) > 0 ? filter(data) { $0.name.lowercaseString.rangeOfString(searchText.lowercaseString) != nil } : data
        self.myCollectionView.reloadData()
    }
    
    @IBAction func addNewItem(sender: UIBarButtonItem) {
        performSegueWithIdentifier("createNewItem", sender: sender)
    }
}
