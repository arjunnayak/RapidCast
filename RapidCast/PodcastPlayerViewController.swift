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
    
    var podcastPlaylist : [String : [Podcast]] = [:]
    
    var player = AVPlayer()
    
    var allPodcasts : [AVPlayerItem] = []
    
    var currentIndex = 0
    
    let playImg = UIImage(named: "Play.png")
    let pauseImg = UIImage(named: "Pause.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (category, podcasts) in podcastPlaylist { //creates podcast queue of av player items
            for podcast in podcasts {
                let item = AVPlayerItem(URL: NSURL(string: podcast.url as! String))
                allPodcasts.append(item)
            }
        }
        self.player = AVPlayer(playerItem: allPodcasts[currentIndex])
        self.player.play()
        pausePlay.setImage(pauseImg, forState: UIControlState.Normal)
    
    }
    
    
    //MARK: Segue Functionality 
    
    @IBAction func goToPlaylist(sender: AnyObject) {
        segueToPlaylist()
    }
    
    func segueToPlaylist() {
        self.performSegueWithIdentifier("showPlaylist", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showPlaylist") {
            var playlistController = segue.destinationViewController as! PodcastPlaylistViewController
            
            playlistController.podcastPlaylist = self.podcastPlaylist
        }
    }
    
    func playPodcast() {
        
    }

    
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
        if(currentIndex == allPodcasts.count - 1) {
            currentIndex = 0
        }
        else {
            currentIndex++
        }
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
        self.player = AVPlayer(playerItem: allPodcasts[currentIndex])
        self.player.play()
    }
    
    @IBAction func sliderMoved(sender: AnyObject) {
        
    }
    
}
