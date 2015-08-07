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
    
    let categories : [Category] = [Category(name: "Arts", image: UIImage(contentsOfFile: "podcast icon.jpeg")!),
        Category(name: "Comedy", image: UIImage(contentsOfFile: "podcast icon.jpeg")!),
        Category(name: "Education", image: UIImage(contentsOfFile: "podcast icon.jpeg")!),
        Category(name: "Kids & Family", image: UIImage(contentsOfFile: "podcast icon.jpeg")!),
        Category(name: "Health", image: UIImage(contentsOfFile: "podcast icon.jpeg")!),
        Category(name: "TV & Film", image: UIImage(contentsOfFile: "podcast icon.jpeg")!),
        Category(name: "Music", image: UIImage(contentsOfFile: "podcast icon.jpeg")!),
        Category(name: "News & Politics", image: UIImage(contentsOfFile: "podcast icon.jpeg")!),
        Category(name: "Science & Medicine", image: UIImage(contentsOfFile: "podcast icon.jpeg")!),
        Category(name: "Sports & Recreation", image: UIImage(contentsOfFile: "podcast icon.jpeg")!),
        Category(name: "Technology", image: UIImage(contentsOfFile: "podcast icon.jpeg")!),
        Category(name: "Business", image: UIImage(contentsOfFile: "podcast icon.jpeg")!),
        Category(name: "Games & Hobbies", image: UIImage(contentsOfFile: "podcast icon.jpeg")!),
        Category(name: "Society & Culture", image: UIImage(contentsOfFile: "podcast icon.jpeg")!),
        Category(name: "Government & Organizations", image: UIImage(contentsOfFile: "podcast icon.jpeg")!)]
    
    
    
    let c : [Category] = [Category(name: "", image: UIImage(contentsOfFile: "podcast icon.jpeg")!)]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
        // Do any additional setup after loading the view.
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
        return 0
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
    
        // Configure the cell
    
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

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
