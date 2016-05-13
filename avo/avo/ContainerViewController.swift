//
//  ContainerViewController.swift
//  avo
//
//  Created by Helen Li, Ryan Huber, and Tiffany Wang on 5/11/16.
//
//  This container holds the paged view, and allows us to customize the
//  position of the paging indicator dots.
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