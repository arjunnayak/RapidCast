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

    var track : NSURL!
    var audioPlayer : AVAudioPlayer?
    
    var player = STKAudioPlayer()
    
    @IBOutlet weak var pausePlay: UIButton!
    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var podcastTitle: UILabel!
    @IBOutlet weak var podcastSlider: UISlider!
    
    let playImg = UIImage(named: "Play.png")
    let pauseImg = UIImage(named: "Pause.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player.playURL(NSURL(string: "http://cdn46.castfire.com/audio/522/3987/27178/2522914/2522914_2015-07-24-152014-7770-0-0-0.64k.mp3?cdn_id=46&uuid=bc898daabaf1d9864f0cd6e95d1b0323"))
        pausePlay.setImage(pauseImg, forState: UIControlState.Normal)
    
    }
    
    
    @IBAction func pressedPlayPause(sender: AnyObject) {
        switch player.state.value {
            case STKAudioPlayerStatePlaying.value: //playing
                pausePlay.setImage(playImg, forState: UIControlState.Normal)
                player.pause()
            case STKAudioPlayerStatePaused.value: //pause
                pausePlay.setImage(pauseImg, forState: UIControlState.Normal)
                player.resume()
            default: println("playpause button not working")
        }
    }
    
    @IBAction func pressedFastForward(sender: AnyObject) {
        
    }
    
    @IBAction func pressedRewind(sender: AnyObject) {
        
    }
    
    @IBAction func sliderMoved(sender: AnyObject) {
        
    }
    
    func updateSlider() {
        
    }
    
    
}
