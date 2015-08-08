//
//  CategoryChooserCollectionViewController.swift
//  RapidCast
//
//  Created by Arjun Nayak on 8/6/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class CategoryChooserCollectionViewController: UICollectionViewController {
    
    private let reuseIdentifier = "CategoryCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    struct Category {
        var name : String
        var image : UIImage
        var isSelected : Bool
    }
    
    var doneButton : UIBarButtonItem?
    
    var chosenCategories : [String] = []
    
    var categories : [Category] = [Category(name: "Arts", image: UIImage(named: "podcast icon.jpeg")!, isSelected: false),
        Category(name: "Comedy", image: UIImage(named: "podcast icon.jpeg")!, isSelected: false),
        Category(name: "Education", image: UIImage(named: "podcast icon.jpeg")!, isSelected: false),
        Category(name: "Kids & Family", image: UIImage(named: "podcast icon.jpeg")!, isSelected: false),
        Category(name: "Health", image: UIImage(named: "podcast icon.jpeg")!, isSelected: false),
        Category(name: "TV & Film", image: UIImage(named: "podcast icon.jpeg")!, isSelected: false),
        Category(name: "Music", image: UIImage(named: "podcast icon.jpeg")!, isSelected: false),
        Category(name: "News & Politics", image: UIImage(named: "podcast icon.jpeg")!, isSelected: false),
        Category(name: "Science & Medicine", image: UIImage(named: "podcast icon.jpeg")!, isSelected: false),
        Category(name: "Sports & Recreation", image: UIImage(named: "podcast icon.jpeg")!, isSelected: false),
        Category(name: "Technology", image: UIImage(named: "podcast icon.jpeg")!, isSelected: false),
        Category(name: "Business", image: UIImage(named: "podcast icon.jpeg")!, isSelected: false),
        Category(name: "Games & Hobbies", image: UIImage(named: "podcast icon.jpeg")!, isSelected: false),
        Category(name: "Society & Culture", image: UIImage(named: "podcast icon.jpeg")!, isSelected: false),
        Category(name: "Government & Organizations", image: UIImage(named: "podcast icon.jpeg")!, isSelected: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "segueToHomeScreen")
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        if let cvl = collectionViewLayout as? UICollectionViewFlowLayout {
            let widthOfCollectionView = cvl.collectionViewContentSize().width
            cvl.itemSize.width = widthOfCollectionView/2.1
            
        }
        
        
        
        collectionView?.allowsMultipleSelection = true
    }
    
    func segueToHomeScreen() {
        self.performSegueWithIdentifier("RapidCast", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "RapidCast") {
            let navigationController = segue.destinationViewController as! UINavigationController
            let rapidCastController : RapidCastViewController = navigationController.viewControllers[0] as! RapidCastViewController
            
            rapidCastController.categories = self.chosenCategories
            
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return categories.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var category = categories[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryCollectionViewCell

        if(category.isSelected) {
            cell.alpha = 0.5
        }
        else {
            //cell.alpha = 1
        }

        cell.categoryName.text = category.name
        cell.categoryImage.image = category.image
        
        return cell
    }

    
    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var category = categories[indexPath.row]
        if !(contains(self.chosenCategories, category.name)) {
            self.chosenCategories.append(category.name)
        }
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell?.alpha = 0.5
        categories[indexPath.row].isSelected = true
        
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let category = categories[indexPath.row]
        if let index = find(self.chosenCategories, category.name) {
            self.chosenCategories.removeAtIndex(index)
            
        }
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell?.alpha = 1
        categories[indexPath.row].isSelected = false
        
        if(chosenCategories.isEmpty) {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
//    // Uncomment this method to specify if the specified item should be highlighted during tracking
//    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func collectionView(collectionView: UICollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    
    /*
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return true
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        
        println(categories[indexPath.row].name)
    
    }
*/
    

}
