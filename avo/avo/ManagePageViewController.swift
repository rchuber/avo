//
//  ViewController.swift
//  avo
//
//  Created by Helen Li, Ryan Huber, and Tiffany Wang on 5/11/16.
//
//  This class provides the controller that allows for paging between different seniors.
//

import UIKit
import CoreData

class ManagePageViewController: UIPageViewController {
    
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    

    var currentIndex: Int!
    var seniorsCount: Int!
    
    weak var containerDelegate: ManagePageViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self

        self.currentIndex = 0
        
        
        // Create a new fetch request using the LogItem entity
        let fetchRequest = NSFetchRequest(entityName: "Senior")
        
        // Execute the fetch request, and cast the results to an array of LogItem objects
        do {
            let seniors = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Senior]
            seniorsCount = seniors!.count
            
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
            containerDelegate?.managePageViewController(self, didUpdatePageCount: seniors!.count)
            
        } catch {
            print("Error retrieving seniors.")
        }


        
    }
    

    func viewSeniorDashboardViewController(index: Int) -> SeniorDashboardViewController? {
        if let storyboard = storyboard,
            page = storyboard.instantiateViewControllerWithIdentifier("seniorDashboardViewStoryboard")
                as? SeniorDashboardViewController {
            
            page.seniorIndex = index
            return page
        }
        return nil
    }
    
    
}


//MARK: implementation of UIPageViewControllerDataSource
extension ManagePageViewController: UIPageViewControllerDataSource {
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
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? SeniorDashboardViewController {

            var index = viewController.seniorIndex
            guard index != NSNotFound else { return nil }
            index = index + 1
            guard index != seniorsCount else {return nil}
            
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




