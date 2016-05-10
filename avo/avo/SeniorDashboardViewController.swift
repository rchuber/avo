//
//  SeniorDashboardController.swift
//

import UIKit

class SeniorDashboardViewController: UIViewController {
    
    public var seniorIndex: Int!
    public var seniorName: String!
    
    @IBOutlet weak var seniorCollectionView: UICollectionView!
    @IBOutlet weak var seniorNameLabel: UILabel!
    
    private var cellIdentifiers: [String] = ["ActivityCell", "MedicationCell","VitalsCell","MentalCell","SleepCell","MessagesCell"]
    
    private var longPressGesture: UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seniorCollectionView.dataSource = self
    
        seniorNameLabel.text = seniorName
        
        /*for i in 0...100 {
            numbers.append(i)
        }*/
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(SeniorDashboardViewController.handleLongGesture(_:)))
        //self.seniorCollectionView.addGestureRecognizer(longPressGesture)
    }
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.Began:
            guard let selectedIndexPath = self.seniorCollectionView.indexPathForItemAtPoint(gesture.locationInView(self.seniorCollectionView)) else {
                break
            }
            seniorCollectionView.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath)
        case UIGestureRecognizerState.Changed:
            seniorCollectionView.updateInteractiveMovementTargetPosition(gesture.locationInView(gesture.view!))
        case UIGestureRecognizerState.Ended:
            seniorCollectionView.endInteractiveMovement()
        default:
            seniorCollectionView.cancelInteractiveMovement()
        }
    }
    
}

 /*extension SeniorDashboardViewController: UICollectionViewDataSource {
 
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        //let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ActivityCell", forIndexPath: indexPath)// as! ActivityCell
        
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! UICollectionViewCell
        cell.backgroundColor = UIColor.redColor()
        
        return cell
        
        
        
        /*print("here!")
        
        var bcolor : UIColor = UIColor( red: 0.2, green: 0.2, blue:0.2, alpha: 0.3 )
        
        cell.layer.borderColor = bcolor.CGColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 3
        
        cell.backgroundColor=UIColor.whiteColor()
        
        
        //cell.text.text = Data[indexPath.row].code
        //cell.country.text = Data[indexPath.row].country
        
        return cell
        */
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 2
    }
    
    //func collectionView(collectionView: UICollectionView,
                       // layout collectionViewLayout: UICollectionViewLayout,
                       //        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        //return CGSize(width: 100  , height: 50)
        
    //}
    
    /*
    
    func seniorCollectionView(seniorCollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 6
 }
 
 func seniorCollectionView(seniorCollectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
 
 /*
 let cell = seniorCollectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! TextCollectionViewCell
 cell.textLabel.text = "\(numbers[indexPath.item])"
 */
 
 //return cell
 }
 
 func seniorCollectionView(seniorCollectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
 
    let temp = numbers.removeAtIndex(sourceIndexPath.item)
    numbers.insert(temp, atIndex: destinationIndexPath.item)
 }*/
 
 }
 */

// MARK:- UICollectionViewDataSource Delegate
extension SeniorDashboardViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellIdentifiers.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var identifier = cellIdentifiers[indexPath.item]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! UICollectionViewCell
        //cell.backgroundColor = UIColor.redColor()
    
    return cell
    }
}


 