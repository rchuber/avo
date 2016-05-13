//
//  SeniorDashboardController.swift
//

import UIKit

class SeniorDashboardViewController: UIViewController {
    
    public var seniorIndex: Int!
    public var seniorName: String!
    
    @IBOutlet weak var seniorCollectionView: UICollectionView!
    @IBOutlet weak var seniorNameLabel: UILabel!
    @IBOutlet weak var seniorImageView: UIImageView!
    
    private var cellIdentifiers: [String] = ["ActivityCell", "MedicationCell","VitalsCell","MentalCell","SleepCell","MessagesCell"]
    
    private var longPressGesture: UILongPressGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seniorCollectionView.dataSource = self
    
        seniorNameLabel.text = seniorName
        
        seniorImageView.image = UIImage(named: seniorName)
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: "handleLongGesture:")
        self.seniorCollectionView.addGestureRecognizer(longPressGesture)
        
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
    
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        let temp = cellIdentifiers.removeAtIndex(sourceIndexPath.item)
        cellIdentifiers.insert(temp, atIndex: destinationIndexPath.item)
    }
}





 