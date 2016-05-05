//
//  ViewController.swift
//  avo
//
//  Created by Ryan Huber on 5/5/16.
//  Copyright © 2016 MHCI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Senior Dashboard as child view controller to the paged scroll view
        let SeniorDashboardViewController = UIViewController(nibName: "SeniorDashboardViewController", bundle: nil)
        self.addChildViewController(SeniorDashboardViewController)
        self.scrollView.addSubview(SeniorDashboardViewController.view)
        SeniorDashboardViewController.didMoveToParentViewController(self)
        
        // Add a second Senior Dashboard to the scroll view
        let SeniorDashboardViewController1 = UIViewController(nibName: "SeniorDashboardViewController", bundle: nil)
        var frame1 = SeniorDashboardViewController1.view.frame
        // push this page over the width of the first screen
        frame1.origin.x = self.view.frame.size.width
        SeniorDashboardViewController1.view.frame = frame1
        SeniorDashboardViewController1.view.backgroundColor = UIColor.yellowColor() // for testing
        self.addChildViewController(SeniorDashboardViewController1)
        self.scrollView.addSubview(SeniorDashboardViewController1.view)
        SeniorDashboardViewController1.didMoveToParentViewController(self)
     
        // Add a second Senior Dashboard to the scroll view
        let SeniorDashboardViewController2 = UIViewController(nibName: "SeniorDashboardViewController", bundle: nil)
        var frame2 = SeniorDashboardViewController2.view.frame
        // push this page over the width of the first screen
        frame2.origin.x = self.view.frame.size.width * 2
        SeniorDashboardViewController2.view.frame = frame2
        SeniorDashboardViewController2.view.backgroundColor = UIColor.greenColor() // for testing
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

