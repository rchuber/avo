//
//  SeniorDashboardController.swift
//

import UIKit

class SeniorDashboardViewController: UIViewController {
    
    var testThing: String = "test!"
    
    @IBOutlet weak var seniorCollectionView: UICollectionView!
    
    //private var numbers: [Int] = []
    
    private var longPressGesture: UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
/*
 extension SeniorDashboardViewController: UICollectionViewDataSource {
 
 func seniorCollectionView(seniorCollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 return numbers.count
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
 }
 
 }
 */