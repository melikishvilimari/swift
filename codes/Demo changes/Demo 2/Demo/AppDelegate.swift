//
//  AppDelegate.swift
//  Demo
//
//  Created by Oleh Sannikov on 25.01.15.
//  Copyright (c) 2015 Oleh Sannikov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, TransitionManagerDelegate, UINavigationControllerDelegate {

    var window: UIWindow?
    var transitionManager = TransitionManager()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        if let navigationController = self.window?.rootViewController as? UINavigationController {
            if let collectionViewController = navigationController.topViewController as? UICollectionViewController {
                transitionManager.collectionView = collectionViewController.collectionView
                transitionManager.delegate = self
                navigationController.delegate = self
            }
        }
        return true
    }

    func interactionBegan(atPoint point: CGPoint) {
        if let navigationController = self.window?.rootViewController as? UINavigationController {

            let viewController = navigationController.topViewController as BaseCollectionViewController
            
            if viewController.canTransitionLayout {
                let grid = viewController.storyboard?.instantiateViewControllerWithIdentifier("grid") as UIViewController
                navigationController.pushViewController(grid, animated: true)
            } else {
                navigationController.popViewControllerAnimated(true)
            }
            
        }
    }
    
    //MARK:
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animationController === self.transitionManager {
            return self.transitionManager
        }
        return nil
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC as? UICollectionViewController != nil && toVC as? UICollectionViewController != nil && self.transitionManager.hasActiveInteraction {
            self.transitionManager.navigationOperation = operation
            return transitionManager
        }
        
        return nil
    }
}

