//
//  MasterViewController.swift
//  iiiiioooooo
//
//  Created by Cleaner on 2/10/15.
//  Copyright (c) 2015 Cleaner. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController:UICollectionViewController,  NSFetchedResultsControllerDelegate, FormViewControllerDelegate {
    
    var managedObjectContext: NSManagedObjectContext? = nil
    var longPressTarget: (cell: UICollectionViewCell, indexPath: NSIndexPath)?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func formControllerDidFinish(controller:FormViewController, model:FormModel){
        let context = self.fetchedResultsController.managedObjectContext
        let entity = self.fetchedResultsController.fetchRequest.entity!
        /*let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context) as NSManagedObject*/

        
        MainTable.createInManagedObjectContext(context, desc: model.Desc!, image: model.Image!, lat: "40.6264", lng: "40.51884", name: model.Name!, minute: model.Minute!, category: model.Category!)
        
        // Save the context.
        var error: NSError? = nil
        if !context.save(&error) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //println("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
        controller.navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func addNew(sender: UIBarButtonItem) {
        insertNewObject(sender)
    }
    
    func insertNewObject(sender: AnyObject) {
        performSegueWithIdentifier("goToForm", sender: self)
        
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToDetails" {
            if let indexPath = sender! as? NSIndexPath {
            }
        }
        else if segue.identifier == "goToForm" {
            var c = segue.destinationViewController as FormViewController
            c.delegate = self
            
        }
        
    }

    // MARK: - Table View

    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as CollectionViewCell
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as MainTable
        var name: String = object.name
        var imageURL: String = object.image
        let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let path = documents.stringByAppendingPathComponent(imageURL)
        cell.imageView.image = UIImage(named: path)
        cell.minuteLabel.text = "\(object.minute) min"
        
        let fileManager = NSFileManager.defaultManager()
        if (fileManager.fileExistsAtPath(path))
        {
            println("FILE AVAILABLE");
            //Pick Image and Use accordingly
            //var imageis: UIImage = UIImage(named: path)!
            //let data: NSData = UIImagePNGRepresentation(imageis)
            //println(data)
        }
        else
        {
            println("FILE NOT AVAILABLE");
        }
        
        println(imageURL)
        cell.recipeName.text = name
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("goToDetails", sender: indexPath)
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject!) -> Bool {
        return true
    }
    
    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
            return CGSize(width: self.view.frame.width / 2, height: self.view.frame.width / 2)
    }

    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("MainTable", inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "image", ascending: false)
        let sortDescriptors = [sortDescriptor]
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
    	var error: NSError? = nil
    	if !_fetchedResultsController!.performFetch(&error) {
    	     // Replace this implementation with code to handle the error appropriately.
    	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             //println("Unresolved error \(error), \(error.userInfo)")
    	     abort()
    	}
        
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController? = nil

    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.collectionView?.updateConstraints()    }

    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
            case .Insert:
            self.collectionView?.insertSections(NSIndexSet(index: sectionIndex))
               // self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            case .Delete:
                self.collectionView?.deleteSections(NSIndexSet(index: sectionIndex))
              //  self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            default:
                return
        }
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
            case .Insert:
            collectionView?.insertItemsAtIndexPaths([newIndexPath!])
               // tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            case .Delete:
            collectionView?.deleteItemsAtIndexPaths([indexPath!])
               // tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            //case .Update:
        
                //self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, atIndexPath: indexPath!)
            case .Move:
                collectionView?.deleteItemsAtIndexPaths([indexPath!])
              //  tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
                collectionView?.insertItemsAtIndexPaths([newIndexPath!])
                //tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            default:
                return
        }
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
       // self.tableView.endUpdates()
    }

}

