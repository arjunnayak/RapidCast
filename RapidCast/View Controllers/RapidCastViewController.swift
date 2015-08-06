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
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) { }
    
    @IBAction func rapidCast(sender: AnyObject) {
        segueToPlayer()
    }
    
    @IBAction func currentPlaylist(sender: AnyObject) {
        println("current playlist button pressed")
        segueToPlaylist()
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

    //MARK: Segue functionality
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch (identifier) {
                case "RapidCast":
                    var navController: UINavigationController = segue.destinationViewController as! UINavigationController
                    var playerController: PodcastPlayerViewController = navController.viewControllers[0] as! PodcastPlayerViewController
                    
                    playerController.podcastPlaylist = finalPlaylist
                case "ShowCurrentPlaylist":
                    println("show current playlist")
                    let navController: UINavigationController = segue.destinationViewController as! UINavigationController
                    let playerController: PodcastPlaylistViewController = navController.viewControllers[0] as! PodcastPlaylistViewController
                    
                    playerController.podcastPlaylist = finalPlaylist
                default:
                    println("segue error")
            }
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
    
    func segueToPlaylist() {
        self.performSegueWithIdentifier("ShowCurrentPlaylist", sender: self)
    }
}