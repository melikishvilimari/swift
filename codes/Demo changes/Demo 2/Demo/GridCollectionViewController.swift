//
//  GridCollectionViewController.swift
//  Demo
//
//  Created by Oleh Sannikov on 26.01.15.
//  Copyright (c) 2015 Oleh Sannikov. All rights reserved.
//

import UIKit

class GridCollectionViewController: BaseCollectionViewController {
    
    override var canTransitionLayout: Bool {
        get {
            return false
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetails" {
            let dstVC = segue.destinationViewController as DetailsViewController
            dstVC.image = images[selectedIndex]
        }
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row
        self.performSegueWithIdentifier("showDetails", sender: self)
    }

}
