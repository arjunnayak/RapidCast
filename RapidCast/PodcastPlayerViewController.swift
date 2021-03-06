//
//  PodcastPlayerViewController.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/13/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import UIKit
import AVFoundation
import SDWebImage
import MarqueeLabel
import StreamingKit

class PodcastPlayerViewController: UIViewController {
    
    //data references
    var categories : [Category] = [] //when you get this to work, clean up the previous logic with allpodcasts/currentindex and have rapidcastviewcontroller set up the categories array and have it send to the other view controllers
    
    struct Category {
        var name : String
        var podcasts : [Podcast]
    }
    
    var podcastPlaylist : [String : [Podcast]] = [:]
    var allPodcasts : [AVPlayerItem] = []
    let indexPodcasts = NSMutableArray()
    var podcasts : [Podcast] = []
    var currentIndex = 0
    
    var volumeToggleState = 0
    
    //audio
    var player = AVPlayer()
    
    //other
    let playImg = UIImage(named: "Play.png")
    let pauseImg = UIImage(named: "Pause.png")
    let volume = UIImage(named: "Volume.png")
    let volumeMuted = UIImage(named: "VolumeMuted.png")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSwipeGestures()
        
        if(podcastPlaylist.isEmpty) {
            print("error: playlist is empty")
        }
        for (category, podcasts) in podcastPlaylist { //creates podcast queue of av player items
            categories.append(Category(name: category, podcasts: podcasts))
            
            for podcast in podcasts {
                if(podcast.title != nil) {
                    self.indexPodcasts.addObject(podcast as Podcast)
                    self.podcasts.append(podcast)
                    let item = AVPlayerItem(URL: NSURL(string: podcast.url as! String)!)
                    self.allPodcasts.append(item)
                }
            }
        }
        self.player = AVPlayer(playerItem: self.allPodcasts[currentIndex])
        self.player.play()
        setupPodcast()
        pausePlay.setImage(pauseImg, forState: UIControlState.Normal)
    }
    
//    override func viewDidAppear(animated: Bool) {
//        let audioControls = AudioControlsView.sharedInstance
//        audioControls.hideView()
//    }
    
    func setupSwipeGestures() {
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector("pressedFastForward:"))
        let swipeRight = UISwipeGestureRecognizer(target: self, action: Selector("pressedRewind:"))
        
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeRight)
        self.podcastImage.addGestureRecognizer(swipeLeft)
        self.podcastImage.addGestureRecognizer(swipeRight)
    }
    
    func setupPodcast() {
        self.podcastImage.image = self.podcasts[currentIndex].imageSaved
        self.titleLabel.text = self.podcasts[currentIndex].title
        self.authorLabel.text = self.podcasts[currentIndex].author
    }
    
    //MARK: UI ELEMENTS
    
    @IBOutlet weak var pausePlay: UIButton!
    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var podcastSlider: UISlider!
    @IBOutlet weak var volumeButton: UIButton!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: MarqueeLabel!
    
    @IBAction func pressedPlayPause(sender: AnyObject) {
        print("tapped play/pause")
        if (self.player.rate != 0 && self.player.error == nil) {           //if player is playing
            self.player.pause()
            pausePlay.setImage(playImg, forState: UIControlState.Normal)
        } else if(self.player.rate == 0) {                                   //if player is paused
            pausePlay.setImage(pauseImg, forState: UIControlState.Normal)
            self.player.play()
        } else {
            print("podcast is buffering")
        }
    }
    
    @IBAction func pressedFastForward(sender: AnyObject) {
        print("tapped next")
        if(currentIndex == allPodcasts.count - 1) {
            currentIndex = 0
        } else {
            currentIndex++
        }
        //for testing
        let podcast = podcasts[currentIndex]
        print("Next Podcast: \(podcast.title)")
        
        self.player.replaceCurrentItemWithPlayerItem(allPodcasts[currentIndex])
        self.player.play()
        setupPodcast()
    }
    
    @IBAction func pressedRewind(sender: AnyObject) {
        print("tapped previous")
        currentIndex = (currentIndex == 0) ? allPodcasts.count - 1 : currentIndex--
        
        //for testing
        let podcast = podcasts[currentIndex]
        print("Previous Podcast: \(podcast.title)")
        
        self.player.replaceCurrentItemWithPlayerItem(allPodcasts[currentIndex])
        self.player.play()
        setupPodcast()
    }
    
    @IBAction func volumeToggle(sender: AnyObject) {
        //if(volumeButton.imageView?.description)
        if(volumeToggleState == 0) {
            self.player.muted = true
            volumeButton.setImage(volumeMuted, forState: UIControlState.Normal)
            volumeToggleState = 1
        }
        else if(volumeToggleState == 1) {
            self.player.muted = false
            volumeButton.setImage(volume, forState: UIControlState.Normal)
            volumeToggleState = 0
        }
    }
    
    @IBAction func sliderMoved(sender: AnyObject) {
        
    }
    
}
