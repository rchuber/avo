//
//  ViewController.swift
//  accordian_2
//
//  Created by Helen Li on 5/11/16.
//  Copyright © 2016 Helen Li. All rights reserved.
//

import UIKit

let cellID = "cell"

var vitals:[String] = ["Blood Pressure", "Heart Rate", "Respiratory Rate", "Body Temperature", "Weight"]

var state:[String] = ["Normal","Normal","Normal","Abnormal", "Normal"]

var bar:[String] = ["Blood Pressure bar.png", "Heart Rate bar.png", "Respiratory Rate bar.png", "Body Temperature bar.png", "Weight bar.png"]

class VitalsTableViewController: UITableViewController {
    
    var selectedIndexPath : NSIndexPath?
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vitals.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! PickerTableViewCell
        //cell.textLabel?.text = vitals[indexPath.row]
        let label_title : UILabel? = self.view.viewWithTag(1) as? UILabel
        label_title?.text = vitals[indexPath.row]
        let state_title : UILabel? = self.view.viewWithTag(2) as? UILabel
        state_title?.text = state[indexPath.row]
        //(cell.title.viewWithTag(1) as? UILabel)!.label = UILabel(named: vitals[indexPath.row])
        (cell.contentView.viewWithTag(3) as? UIImageView)!.image = UIImage(named: bar[indexPath.row])
        
        if indexPath.row == 3 {
            cell.backgroundColor = UIColor(red:0.92, green:0.43, blue:0.48, alpha:1.0)
        } else {
            cell.backgroundColor = UIColor(red:0.46, green:0.87, blue:0.60, alpha:1.0)
        }
        
        //cell.title.text = "Blood Pressure"
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        var indexPaths : Array<NSIndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
        //colors the selected row red
        let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!

        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! PickerTableViewCell).watchFrameChanges()
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! PickerTableViewCell).ignoreFrameChanges()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            return PickerTableViewCell.expandedHeight
        } else {
            return PickerTableViewCell.defaultHeight
        }
    }
    
}

