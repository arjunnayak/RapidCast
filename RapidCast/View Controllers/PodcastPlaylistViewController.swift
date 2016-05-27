//
//  PodcastPlaylistViewController.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/15/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import UIKit
import AVFoundation
import StreamingKit

class PodcastPlaylistViewController: UITableViewController {

    var podcastPlaylist : [String : [Podcast]] = [:]
    var categories : [Category] = []
    var allPodcasts : [Podcast] = []
    var selectedPodcastIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        tableView.dataSource = self
        tableView.delegate = self

        for (category, podcasts) in podcastPlaylist { //creates podcast queue of podcasts
            categories.append(Category(name: category, podcasts: podcasts))
            for podcast in podcasts {
                if (podcast.url != nil) {
                    allPodcasts.append(podcast)
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.title = "Playlist"
        
        let audioPlayer = AudioPlayer.sharedInstance
        if(audioPlayer.getState() == STKAudioPlayerState.Running) {
            AudioControlsView.sharedInstance.showView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if(identifier == "PlayPodcast") {
                let playerViewController = segue.destinationViewController as! PodcastPlayerViewController
                playerViewController.currentIndex = self.selectedPodcastIndex
                playerViewController.podcastPlaylist = self.podcastPlaylist
            } else if(identifier == "SKPlayPodcast") {
                let SKplayerViewController = segue.destinationViewController as! SKPodcastPlayerViewController
                SKplayerViewController.selectedPodcast = allPodcasts[self.selectedPodcastIndex]
            }
        }
    }

    //MARK: Table View Implementation
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return categories.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories[section].podcasts!.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> PodcastTableViewCell {
        let podcast = categories[indexPath.section].podcasts![indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("PodcastCell", forIndexPath: indexPath) as! PodcastTableViewCell
        cell.podcast = podcast
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let podcast = categories[indexPath.section].podcasts![indexPath.row]
        
        //this block of code finds the right podcast to display on the player based on what cell was selected.
        //this is necessary because of the headers, the rows of the index path were reset with every new header
        var index = 0
        for i in (0...allPodcasts.count) {
            if(podcast.url == allPodcasts[i].url) {
                index = i
                break
            }
        }
        self.selectedPodcastIndex = index
        performSegueWithIdentifier("PlayPodcast", sender: self)
//        self.performSegueWithIdentifier("SKPlayPodcast", sender: self)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].name
    }

}

