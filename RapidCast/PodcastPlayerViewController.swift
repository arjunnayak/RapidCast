//
//  PodcastPlayerViewController.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/13/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import UIKit
import AVFoundation


class PodcastPlayerViewController: UIViewController {
    
    //data references
    var categories : [Category] = [] //when you get this to work, clean up the previous logic with allpodcasts/currentindex and have rapidcastviewcontroller set up the categories array and have it send to the other view controllers
    
    struct Category {
        var name : String
        var podcasts : [Podcast]
    }
    
    var podcastPlaylist : [String : [Podcast]] = [:]
    var allPodcasts : [AVPlayerItem] = []
    var indexPodcasts = NSMutableArray()
    var podcasts : [Podcast] = []
    var currentIndex = 0
    
    //audio
    var player = AVPlayer()
    
    //other
    let playImg = UIImage(named: "Play.png")
    let pauseImg = UIImage(named: "Pause.png")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(podcastPlaylist.isEmpty) {
            println("you're fucked")
        }
        for (category, podcasts) in podcastPlaylist { //creates podcast queue of av player items
            categories.append(Category(name: category, podcasts: podcasts))
            
            for podcast in podcasts {
                self.indexPodcasts.addObject(podcast as Podcast)
                self.podcasts.append(podcast)
                let item = AVPlayerItem(URL: NSURL(string: podcast.url as! String))
                self.allPodcasts.append(item)
               
            }
        }
        self.player = AVPlayer(playerItem: self.allPodcasts[currentIndex])
        self.player.play()
        self.podcastImage.image = self.podcasts[currentIndex].image
        pausePlay.setImage(pauseImg, forState: UIControlState.Normal)
    }
    
    
    //MARK: Segue Functionality 
    /*
    @IBAction func goToPlaylist(sender: AnyObject) {
        
    }
    
    func segueToPlaylist() {
        self.performSegueWithIdentifier("showPlaylist", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showPlaylist") {
            var playlistController = segue.destinationViewController as! PodcastPlaylistViewController
            self.player.pause()
            playlistController.podcastPlaylist = self.podcastPlaylist
        }
    }
*/

    
    //MARK: UI ELEMENTS
    
    @IBOutlet weak var pausePlay: UIButton!
    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var podcastTitle: UILabel!
    @IBOutlet weak var podcastSlider: UISlider!
    
    @IBAction func pressedPlayPause(sender: AnyObject) {
        
        if (self.player.rate != 0 && self.player.error == nil) {           //if player is playing
            self.player.pause()
            pausePlay.setImage(playImg, forState: UIControlState.Normal)
        }
        else if(self.player.rate == 0) {                                   //if player is paused
            pausePlay.setImage(pauseImg, forState: UIControlState.Normal)
            self.player.play()
        }
        else {
            println("podcast is buffering")
        }
    }
    
    @IBAction func pressedFastForward(sender: AnyObject) {

       // self.player.
        if(currentIndex == allPodcasts.count - 1) {
            currentIndex = 0
        }
        else {
            currentIndex++
        }
        //for testing
        let podcast = podcasts[currentIndex]
        println("Next Podcast: \(podcast.title)")
        
        self.podcastImage.image = podcasts[currentIndex].image
        self.player = AVPlayer(playerItem: allPodcasts[currentIndex])
        self.player.play()

    }
    
    @IBAction func pressedRewind(sender: AnyObject) {
        if(currentIndex == 0) {
            currentIndex = allPodcasts.count - 1
        }
        else {
            currentIndex--
        }
        //for testing
        let podcast = podcasts[currentIndex]
        println("Previous Podcast: \(podcast.title)")
        
        
        self.podcastImage.image = podcasts[currentIndex].image
        self.player = AVPlayer(playerItem: allPodcasts[currentIndex])
        self.player.play()
    }
    
    @IBAction func sliderMoved(sender: AnyObject) {
        
    }
    
}
