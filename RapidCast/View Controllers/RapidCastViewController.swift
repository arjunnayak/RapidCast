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
    var categories: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        rapidCastButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        //REALM STUFF TO GET CATEGORIES
        //HARDCODED FOR NOW
        categories = ["Comedy", "Education"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "RapidCast") {
            let podcastPlayer = segue.destinationViewController as! PodcastPlayerViewController
            if let categories = self.categories {
                var iTunesLinks : [String] = iTunesHelper.getiTunesLinksFromRSS(categories)
                
            }
            else {
                println("Error")
            }
        }
        
    }
    
    
}
