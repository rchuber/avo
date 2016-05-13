//
//  ContainerViewController.swift
//  avo
//
//  Created by Ryan Huber on 5/12/16.
//  Copyright © 2016 MHCI. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let managePageViewController = segue.destinationViewController as? ManagePageViewController {
            managePageViewController.containerDelegate = self
        }
    }
 
    
}

extension ContainerViewController: ManagePageViewControllerDelegate {
    
    func managePageViewController(managePageViewController: ManagePageViewController,
                                  didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func managePageViewController(managePageViewController: ManagePageViewController,
                                  didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}