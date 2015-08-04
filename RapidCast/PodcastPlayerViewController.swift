//
//  PodcastPlayerViewController.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/13/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import UIKit
import AVFoundation
import StreamingKit


class PodcastPlayerViewController: UIViewController {
    
    var podcastPlaylist : [String : [Podcast]] = [:]
    
    var player = AVPlayer()
    
    var allPodcasts : [AVPlayerItem] = []
    
    var currentIndex = 0
    
    @IBOutlet weak var pausePlay: UIButton!
    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var podcastTitle: UILabel!
    @IBOutlet weak var podcastSlider: UISlider!
    
    let playImg = UIImage(named: "Play.png")
    let pauseImg = UIImage(named: "Pause.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (category, podcasts) in podcastPlaylist {
            for podcast in podcasts {
                let item = AVPlayerItem(URL: NSURL(string: podcast.url as! String))
                allPodcasts.append(item)
            }
        }
        
//        var podcastArr = podcastPlaylist["Technology"]
//        var podcast = podcastArr![0]
        self.player = AVPlayer(playerItem: allPodcasts[currentIndex])
        self.player.play()
        pausePlay.setImage(pauseImg, forState: UIControlState.Normal)
    
    }
    
    @IBAction func pressedPlayPause(sender: AnyObject) {
//        switch player.state.value {
//            case STKAudioPlayerStatePlaying.value: //playing
//                pausePlay.setImage(playImg, forState: UIControlState.Normal)
//                player.pause()
//            case STKAudioPlayerStatePaused.value: //pause
//                pausePlay.setImage(pauseImg, forState: UIControlState.Normal)
//                player.resume()
//            default: println("playpause button not working")
//        }
        
       //if(
        
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
