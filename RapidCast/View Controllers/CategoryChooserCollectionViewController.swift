//
//  CategoryChooserCollectionViewController.swift
//  RapidCast
//
//  Created by Arjun Nayak on 8/6/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import UIKit


class CategoryChooserCollectionViewController: UICollectionViewController {
    
    var doneButton : UIBarButtonItem?
    var chosenCategories = [Category]()
    
    //MARK: Category list
    var categories : [Category] = [Category(name: "Arts", image: UIImage(named: "Arts")!, isSelected: false),
        Category(name: "Comedy", image: UIImage(named: "Comedy")!, isSelected: false),
        Category(name: "Education", image: UIImage(named: "Education")!, isSelected: false),
        Category(name: "Kids & Family", image: UIImage(named: "Kids&Family")!, isSelected: false),
        Category(name: "Health", image: UIImage(named: "Health")!, isSelected: false),
        Category(name: "TV & Film", image: UIImage(named: "TV&Film")!, isSelected: false),
        Category(name: "Music", image: UIImage(named: "Music")!, isSelected: false),
        Category(name: "News & Politics", image: UIImage(named: "News&Politics")!, isSelected: false),
        Category(name: "Science & Medicine", image: UIImage(named: "Science&Medicine")!, isSelected: false),
        Category(name: "Sports & Recreation", image: UIImage(named: "Sports&Recreation")!, isSelected: false),
        Category(name: "Technology", image: UIImage(named: "Technology")!, isSelected: false),
        Category(name: "Business", image: UIImage(named: "Business")!, isSelected: false),
        Category(name: "Games & Hobbies", image: UIImage(named: "Games&Hobbies")!, isSelected: false),
        Category(name: "Society & Culture", image: UIImage(named: "Society&Culture")!, isSelected: false),
        Category(name: "Government", image: UIImage(named: "Government")!, isSelected: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//      check if user defaults already has this value before setting it
        NSUserDefaults.standardUserDefaults().setObject("initialOpen", forKey: "first")
        
        doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "segueToHomeScreen")
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.allowsMultipleSelection = true
        
        if let cvl = collectionViewLayout as? UICollectionViewFlowLayout {
            let widthOfCollectionView = cvl.collectionViewContentSize().width
            cvl.itemSize.width = widthOfCollectionView/2.1
        }

    }
    
    func segueToHomeScreen() {
        var stringCategories = [String]()
        for cat in chosenCategories {
            stringCategories.append(cat.name)
        }
        print(stringCategories)
        NSUserDefaults.standardUserDefaults().setObject(stringCategories, forKey: "chosen_categories")
        self.performSegueWithIdentifier("RapidCast", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let category = categories[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryCollectionViewCell
        cell.alpha = 0.25

        if let selected = category.isSelected {
            if(selected) {
                cell.alpha = 1.0
            }
        }

        cell.categoryName.text = category.name
        cell.categoryImage.image = category.image
        
        return cell
    }

    
    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let category: Category = categories[indexPath.row]
        chosenCategories.append(category)
        category.isSelected = true
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell?.alpha = 1
        
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
        let category = categories[indexPath.row]
        let index = chosenCategories.indexOf({$0.name == category.name})
        if let i = index {
            chosenCategories.removeAtIndex(i)
        }
        category.isSelected = false
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        cell?.alpha = 0.25
        
        if(chosenCategories.count == 0) {
            self.navigationItem.rightBarButtonItem = nil
        }
        
    }
    
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func collectionView(collectionView: UICollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

}
