//
//  BaseCollectionViewController.swift
//  Demo
//
//  Created by Oleh Sannikov on 26.01.15.
//  Copyright (c) 2015 Oleh Sannikov. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class BaseCollectionViewController: UICollectionViewController {
    lazy var images: Array<UIImage> = self.loadDataImages()
    var selectedIndex: Int = 0
    var canTransitionLayout: Bool {
        get {
            return true
        }
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as CollectionViewCell
        cell.image?.image = images[indexPath.row]
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout! {
        return TransitionLayout(currentLayout:fromLayout, nextLayout:toLayout)
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row
        self.performSegueWithIdentifier("showGrid", sender: self)
    }
    
    // MARK:
    func loadDataImages() -> Array<UIImage> {
        var result = Array<UIImage>()
        
        for var i = 0; i < 19; i++ {
            let image = UIImage(named: "sa\(i).jpg")
            result.append(image!)
        }
        return result
    }
    
}
