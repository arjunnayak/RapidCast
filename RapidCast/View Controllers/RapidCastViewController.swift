//
//  RapidCastViewController.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/20/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import UIKit

class RapidCastViewController: UIViewController {
    
    @IBOutlet weak var rapidCastButton: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}

    var categories: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        rapidCastButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        //REALM STUFF TO GET CATEGORIES
        categories = ["Comedy", "Education", "Technology", "Arts"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "RapidCast") {
            
            if let categories = self.categories {
                ContentGenerator.generate(categories)
            }
            let podcastPlayer = segue.destinationViewController as! PodcastPlayerViewController
            //needs to send playlist of podcasts to podcast player AND playlist
        }
    }
}