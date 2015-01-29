//
//  TransitionManager.swift
//  Demo
//
//  Created by Oleh Sannikov on 25.01.15.
//  Copyright (c) 2015 Oleh Sannikov. All rights reserved.
//

import UIKit

protocol TransitionManagerDelegate {
    func interactionBegan(atPoint point:CGPoint);
}

class TransitionManager : NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning {
 
    var transitionLayout: TransitionLayout?
    var context: UIViewControllerContextTransitioning?
    var hasActiveInteraction: Bool = false

    var collectionView: UICollectionView? {
        didSet {
            let pinch = UIPinchGestureRecognizer(target: self, action: "handlePinch:")
            collectionView?.addGestureRecognizer(pinch)
        }
    }
    var delegate: TransitionManagerDelegate?
    var navigationOperation: UINavigationControllerOperation = .None
    var initialPinchDistance: CGFloat = 0
    var initialPinchPoint: CGPoint = CGPointZero
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1.0
    }
    
    func startInteractiveTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.context = transitionContext
        
        let srcVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as UICollectionViewController
        let dstVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as UICollectionViewController
        
        let containerView = transitionContext.containerView()
        containerView.addSubview(dstVC.view)
        
        self.transitionLayout = srcVC.collectionView?.startInteractiveTransitionToCollectionViewLayout(dstVC.collectionViewLayout, completion: {
            didFinish, didComplete in
            self.context?.completeTransition(didComplete)
            self.transitionLayout = nil
            self.context = nil
            self.hasActiveInteraction = false
        }) as? TransitionLayout
    }
 
    func update(progress: CGFloat, offset: UIOffset) {
        if transitionLayout != nil && self.context != nil {
            if  progress != transitionLayout?.transitionProgress || !UIOffsetEqualToOffset(offset, transitionLayout!.offset!) {
                transitionLayout?.offset = offset
                transitionLayout?.transitionProgress = progress
                transitionLayout?.invalidateLayout()
                self.context?.updateInteractiveTransition(progress)
            }
        }
    }
 
    func endInteraction(success: Bool) {
        if self.context == nil {
            self.hasActiveInteraction = false
        } else if self.transitionLayout?.transitionProgress > 0.1 && success {
            self.collectionView?.finishInteractiveTransition()
            self.context?.finishInteractiveTransition()
        } else {
            self.collectionView?.cancelInteractiveTransition()
            self.context?.cancelInteractiveTransition()
        }
    }
    
    func handlePinch(sender: UIPinchGestureRecognizer) {
 
        if sender.state == .Ended {
            self.endInteraction(true)
        } else if sender.state == .Cancelled {
            self.endInteraction(false)
        } else if sender.numberOfTouches() == 2 {
            let point = sender.locationInView(sender.view)
            let point1 = sender.locationOfTouch(0, inView: sender.view)
            let point2 = sender.locationOfTouch(1, inView: sender.view)
            let d = (point1.x - point2.x) * (point1.x - point2.x) + (point1.y - point2.y) * (point1.y - point2.y)
            let distance = sqrt(d)
            println(sender.state.rawValue)
            if sender.state == .Began {
                if !self.hasActiveInteraction {
                    self.initialPinchDistance = distance
                    self.initialPinchPoint = point
                    self.hasActiveInteraction = true
                    self.delegate?.interactionBegan(atPoint:point)
                }
            }

            if self.hasActiveInteraction {
                if sender.state == .Changed {
                    let offsetX = point.x - self.initialPinchPoint.x
                    let offsetY = point.y - self.initialPinchPoint.y
                    let offsetToUse = UIOffsetMake(offsetX, offsetY)
                    var distanceDelta = distance - self.initialPinchDistance;

                    if self.navigationOperation == .Pop {
                        distanceDelta = -distanceDelta
                    }
                    let dimension = sqrt(self.collectionView!.bounds.size.width * self.collectionView!.bounds.size.width + self.collectionView!.bounds.size.height * self.collectionView!.bounds.size.height)
                    let progress = max(min((distanceDelta / dimension), 1.0), 0.0)
                    
                    self.update(progress, offset:offsetToUse)
                }
            }
        }
    }
    
}
