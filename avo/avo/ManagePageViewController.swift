//
//  ViewController.swift
//  avo
//
//  Created by Ryan Huber on 5/5/16.
//  Copyright © 2016 MHCI. All rights reserved.
//


import UIKit
import CoreData

class ManagePageViewController: UIPageViewController {
    var seniors = ["Granny", "Grammy", "Grampy","BOB"]

    var currentIndex: Int!
    weak var containerDelegate: ManagePageViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self

        self.currentIndex = 0
        
        // 1
        if let viewController = viewSeniorDashboardViewController(currentIndex ?? 0) {
            let viewControllers = [viewController]
            // 2
            setViewControllers(
                viewControllers,
                direction: .Forward,
                animated: false,
                completion: nil
            )
        }
        
        // need to send page view info to the parent
        containerDelegate?.managePageViewController(self, didUpdatePageCount: seniors.count)
        
    }
    

    func viewSeniorDashboardViewController(index: Int) -> SeniorDashboardViewController? {
        if let storyboard = storyboard,
            page = storyboard.instantiateViewControllerWithIdentifier("seniorDashboardViewStoryboard")
                as? SeniorDashboardViewController {
            
            page.seniorName = seniors[index]
            page.seniorIndex = index
            return page
        }
        return nil
    }
    
    
}


//MARK: implementation of UIPageViewControllerDataSource
extension ManagePageViewController: UIPageViewControllerDataSource {
    // 1
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? SeniorDashboardViewController {

            var index = viewController.seniorIndex
            guard index != NSNotFound && index != 0 else { return nil }
            index = index - 1
            
            
            return viewSeniorDashboardViewController(index)
        }
        return nil
    }
    
    // 2
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? SeniorDashboardViewController {

            var index = viewController.seniorIndex
            guard index != NSNotFound else { return nil }
            index = index + 1
            guard index != seniors.count else {return nil}
            
            return viewSeniorDashboardViewController(index)
            
        }
        return nil
    }
}




 extension ManagePageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                                               previousViewControllers: [UIViewController],
                                               transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first as? SeniorDashboardViewController,
        let index = firstViewController.seniorIndex {//seniors.indexOf(firstViewController.seniorIndex) {
            containerDelegate?.managePageViewController(self, didUpdatePageIndex: index)
        }
    }
    
}


protocol ManagePageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter managePageViewController: the ManagePageViewController instance
     - parameter count: the total number of pages.
     */
    func managePageViewController(managePageViewController: ManagePageViewController,
                                  didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter managePageViewController: the ManagePageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func managePageViewController(managePageViewController: ManagePageViewController,
                                  didUpdatePageIndex index: Int)
    
}




