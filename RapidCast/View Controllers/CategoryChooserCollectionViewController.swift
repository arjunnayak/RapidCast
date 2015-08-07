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
    }
    
    let categories : [Category] = [Category(name: "Arts", image: UIImage(named: "podcast icon.jpeg")!),
        Category(name: "Comedy", image: UIImage(named: "podcast icon.jpeg")!),
        Category(name: "Education", image: UIImage(named: "podcast icon.jpeg")!),
        Category(name: "Kids & Family", image: UIImage(named: "podcast icon.jpeg")!),
        Category(name: "Health", image: UIImage(named: "podcast icon.jpeg")!),
        Category(name: "TV & Film", image: UIImage(named: "podcast icon.jpeg")!),
        Category(name: "Music", image: UIImage(named: "podcast icon.jpeg")!),
        Category(name: "News & Politics", image: UIImage(named: "podcast icon.jpeg")!),
        Category(name: "Science & Medicine", image: UIImage(named: "podcast icon.jpeg")!),
        Category(name: "Sports & Recreation", image: UIImage(named: "podcast icon.jpeg")!),
        Category(name: "Technology", image: UIImage(named: "podcast icon.jpeg")!),
        Category(name: "Business", image: UIImage(named: "podcast icon.jpeg")!),
        Category(name: "Games & Hobbies", image: UIImage(named: "podcast icon.jpeg")!),
        Category(name: "Society & Culture", image: UIImage(named: "podcast icon.jpeg")!),
        Category(name: "Government & Organizations", image: UIImage(named: "podcast icon.jpeg")!)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneButton = self.navigationItem.rightBarButtonItem
        
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(), animated: true)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        if let cvl = collectionViewLayout as? UICollectionViewFlowLayout {
            let widthOfCollectionView = cvl.collectionViewContentSize().width
            cvl.itemSize.width = widthOfCollectionView/2.1
            
        }
        
//      self.collectionView!.registerClass(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
        let category = categories[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryCollectionViewCell
//        Instead of hardcoding the item sizes in -collectionView:layout:sizeForItemAtIndexPath, just divide the height or width of the collectionView's bounds by the number of cells you want to fit on screen. Use the height if your collectionView scrolls horizontally or the width if it scrolls vertically.

        cell.categoryName.text = category.name
        cell.categoryImage.image = category.image
        
        return cell
    }
    


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
*/
    

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return true
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        
        println(categories[indexPath.row].name)
    
    }
    

}
