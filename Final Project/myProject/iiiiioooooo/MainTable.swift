//
//  MainTable.swift
//  iiiiioooooo
//
//  Created by Admin on 2/27/15.
//  Copyright (c) 2015 Cleaner. All rights reserved.
//

import Foundation
import CoreData

class MainTable: NSManagedObject {

    @NSManaged var desc: String
    @NSManaged var image: String
    @NSManaged var lat: String?
    @NSManaged var lng: String?
    @NSManaged var name: String
    @NSManaged var minute: String
    @NSManaged var category: String
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext,
        desc: String, image: String, lat: String?, lng: String?, name: String, minute: String, category: String) -> MainTable {
            
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("MainTable", inManagedObjectContext: moc) as! MainTable
        
        newItem.desc = desc
        newItem.image = image
        newItem.lat = lat
        newItem.lng = lng
        newItem.name = name
        newItem.minute = minute
        newItem.category = category
        
        return newItem
    }

}
