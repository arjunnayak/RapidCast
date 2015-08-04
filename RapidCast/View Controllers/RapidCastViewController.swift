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
    
    @IBAction func rapidCast(sender: AnyObject) {
        segueToPlayer()
    }
    var categories: [String]?
    
    var finalPlaylist : [String : [Podcast]] = [:]

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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        if(segue.identifier == "RapidCast") {
            
            var navController: UINavigationController = segue.destinationViewController as! UINavigationController
            var playerController: PodcastPlayerViewController = navController.viewControllers[0] as! PodcastPlayerViewController
            //var player = segue.destinationViewController as! PodcastPlayerViewController
            playerController.podcastPlaylist = finalPlaylist
            
            //needs to send playlist of podcasts to podcast player AND playlist
        }
    }
    
    func segueToPlayer() {
        if let categories = self.categories {
            ContentGenerator.generate(categories) { finalPlaylist in //final playlist created
                self.finalPlaylist = finalPlaylist
                self.performSegueWithIdentifier("RapidCast", sender: self)
            }
        }
    }
}