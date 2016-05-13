//
//  PickerTableViewCell.swift
//  accordian_2
//
//  Created by Helen Li on 5/11/16.
//  Copyright © 2016 Helen Li. All rights reserved.
//

import UIKit
import CoreData


class PickerTableViewCell : UITableViewCell {
    
    var isObserving = false;
    
    @IBOutlet weak var infoGraphic: UIImageView!
    
    class var expandedHeight: CGFloat { get { return  200  } }
    
    class var defaultHeight: CGFloat { get { return  44  } }
    
    func checkHeight() {
        infoGraphic.hidden  = (frame.size.height == PickerTableViewCell.defaultHeight)
    }
    
    func watchFrameChanges() {
        if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.New, NSKeyValueObservingOptions.Initial], context: nil)
            isObserving = true;
        }
    }
    
    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false;
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
    
}


