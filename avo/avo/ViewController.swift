//
//  ViewController.swift
//  avo
//
//  Created by Ryan Huber on 5/5/16.
//  Copyright © 2016 MHCI. All rights reserved.
//


import UIKit

class ManagePageViewController: UIPageViewController {
    var seniors = ["Granny", "Grammy", "Grampy"]
    var currentIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
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
    
    // MARK: UIPageControl
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return seniors.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return currentIndex ?? 0
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



/*

class ViewController: UIPageViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Senior Dashboard as child view controller to the paged scroll view
        //let SeniorDashboardViewController0 = SeniorDashboardViewController()
        
        let SeniorDashboardViewController0:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("seniorDashboardViewStoryboard") as UIViewController
        //self.presentViewController(SeniorDashboardViewController0, animated: false, completion: nil)
        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
        self.addChildViewController(SeniorDashboardViewController0)
        self.scrollView.addSubview(SeniorDashboardViewController0.view)
        SeniorDashboardViewController0.didMoveToParentViewController(self)

        // Add a second Senior Dashboard to the scroll view
        let SeniorDashboardViewController1:SeniorDashboardViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("seniorDashboardViewStoryboard") as! SeniorDashboardViewController

        var frame1 = SeniorDashboardViewController1.view.frame
        // push this page over the width of the first screen
        frame1.origin.x = self.view.frame.size.width
        SeniorDashboardViewController1.view.frame = frame1
        print(SeniorDashboardViewController1.testThing)
        SeniorDashboardViewController1.view.backgroundColor = UIColor.redColor() // for testing
        SeniorDashboardViewController1.seniorCollectionView.backgroundColor = UIColor.yellowColor() // for testing
        self.addChildViewController(SeniorDashboardViewController1)
        self.scrollView.addSubview(SeniorDashboardViewController1.view)
        SeniorDashboardViewController1.didMoveToParentViewController(self)
     
        
        // Add a third Senior Dashboard to the scroll view
        let SeniorDashboardViewController2:SeniorDashboardViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("seniorDashboardViewStoryboard") as! SeniorDashboardViewController

        var frame2 = SeniorDashboardViewController2.view.frame
        // push this page over the width of the first screen
        frame2.origin.x = self.view.frame.size.width * 2
        SeniorDashboardViewController2.view.frame = frame2
        SeniorDashboardViewController2.view.backgroundColor = UIColor.blueColor() // for testing
        SeniorDashboardViewController2.seniorCollectionView.backgroundColor = UIColor.orangeColor() // for testing
        self.addChildViewController(SeniorDashboardViewController2)
        self.scrollView.addSubview(SeniorDashboardViewController2.view)
        SeniorDashboardViewController1.didMoveToParentViewController(self)
 
 
        // set width to be the width of all view controllers side by side
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width * 3, height: self.view.frame.size.height)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 }
*/


