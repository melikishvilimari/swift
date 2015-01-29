//
//  TransitionLayout.swift
//  Demo
//
//  Created by Oleh Sannikov on 25.01.15.
//  Copyright (c) 2015 Oleh Sannikov. All rights reserved.
//

import UIKit

class TransitionLayout: UICollectionViewTransitionLayout {

    private let offsetH = "offsetH"
    private let offsetV = "offsetV"

    var offset: UIOffset? {
        didSet {
            if offset != nil {
                self.updateValue(offset!.horizontal, forAnimatedKey:offsetH)
                self.updateValue(offset!.vertical, forAnimatedKey:offsetV)
            }
        }
    }
    
    override init(currentLayout: UICollectionViewLayout, nextLayout newLayout: UICollectionViewLayout) {
        super.init(currentLayout: currentLayout, nextLayout:newLayout)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var transitionProgress: CGFloat {
        didSet {
            offset = UIOffset(horizontal:self.valueForAnimatedKey(offsetH), vertical:self.valueForAnimatedKey(offsetV))
        }
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        if let attributes = super.layoutAttributesForElementsInRect(rect) as? [UICollectionViewLayoutAttributes] {
            if offset != nil {
                for attribute in attributes {
                    let center = attribute.center
                    attribute.center = CGPointMake(center.x + self.offset!.horizontal, center.y + self.offset!.vertical);
                }
            }
            return attributes
        }
        return nil
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        let attribute = super.layoutAttributesForItemAtIndexPath(indexPath)
        if offset != nil {
            let center = attribute.center
            attribute.center = CGPointMake(center.x + self.offset!.horizontal, center.y + self.offset!.vertical);
        }
        return attribute
    }
}
