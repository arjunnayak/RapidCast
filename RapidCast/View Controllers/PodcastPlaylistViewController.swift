//
//  PodcastPlaylistViewController.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/15/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import UIKit
import AVFoundation

class PodcastPlaylistViewController: UITableViewController {

    //for setup
    var podcastPlaylist : [String : [Podcast]] = [:]
    var categories : [Category] = []
    
    struct Category {
        var name : String
        var podcasts : [Podcast]
    }
    
    //for referencing podcasts
    var allPodcasts : [Podcast] = []
    //var indexPodcasts = NSMutableArray()
    
    var selectedPodcastIndex = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        tableView.dataSource = self
        tableView.delegate = self
        //println("podcastPlaylist is empty: \(podcastPlaylist.isEmpty))")
        for (category, podcasts) in podcastPlaylist { //creates podcast queue of podcasts
            
            categories.append(Category(name: category, podcasts: podcasts))
            
            for podcast in podcasts {
                if (podcast.url != nil) {
                    allPodcasts.append(podcast)
                }
                
                //self.indexPodcasts.addObject(podcast as Podcast)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationItem.title = "Playlist"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if(identifier == "PlayPodcast") {
                let playerViewController = segue.destinationViewController as! PodcastPlayerViewController
                let path = self.tableView.indexPathForSelectedRow()!

                playerViewController.currentIndex = self.selectedPodcastIndex
                playerViewController.podcastPlaylist = self.podcastPlaylist

                //CURRENT THOUGHTS:
                //        create nsmutablearray of Podcasts, and so when a Podcast object in the table view is selected, search through the NSMutableArray using NSMutableArray.indexOfObject(Podcast selected) and set that to the current Index so that the queue functionality with currentIndex will work.

            }
        }
    }

    //MARK: Table View Implementation
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return categories.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories[section].podcasts.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> PodcastTableViewCell {
        let podcast = categories[indexPath.section].podcasts[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PodcastCell", forIndexPath: indexPath) as! PodcastTableViewCell
        
        cell.podcast = podcast
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let podcast = categories[indexPath.section].podcasts[indexPath.row]
        //self.selectedPodcastIndex = allPodcasts.find { $0 == podcast }!
        
        
        //this block of code finds the right podcast to display on the player based on what cell was selected. 
        //this is necessary because of the headers, the rows of the index path were reset with every new header
        var index = 0
        finding: for i in (0...allPodcasts.count) {
            if(podcast.url == allPodcasts[i].url) {
                index = i
                break finding
            }
        }
        self.selectedPodcastIndex = index
        
        performSegueWithIdentifier("PlayPodcast", sender: self)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].name
    }

}

