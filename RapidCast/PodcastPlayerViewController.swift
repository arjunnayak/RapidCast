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

    var track : NSURL!
    var audioPlayer : AVAudioPlayer?
    
    @IBOutlet weak var pausePlay: UIButton!
    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var podcastTitle: UILabel!
    @IBOutlet weak var podcastSlider: UISlider!
    
    let playImg = UIImage(named: "Play.png")
    let pauseImg = UIImage(named: "Pause.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up track and audioplayer
        track = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("jazzy.mp3", ofType: "mp3")!)
        audioPlayer = AVAudioPlayer(contentsOfURL: track, error: nil)

        
        //slider functionality
        podcastSlider.maximumValue = Float(audioPlayer!.duration)
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateSlider"), userInfo: nil, repeats: true)
        
        if(audioPlayer!.playing == false) {
            pausePlay.setImage(playImg, forState: UIControlState.Normal)
        }
    }
    
    @IBAction func pressedPlayPause(sender: AnyObject) {
        if(audioPlayer!.playing) { //track is playing
            audioPlayer?.pause()
            pausePlay.setImage(playImg, forState: UIControlState.Normal)
        }
        else  //track is paused
        {
            audioPlayer?.play()
            pausePlay.setImage(pauseImg, forState: UIControlState.Normal)
        }
    }
    
    @IBAction func pressedFastForward(sender: AnyObject) {
        
    }
    
    @IBAction func pressedRewind(sender: AnyObject) {
        
    }
    
    @IBAction func sliderMoved(sender: AnyObject) {
        
        audioPlayer?.stop()
        audioPlayer?.currentTime = NSTimeInterval(podcastSlider.value)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
    }
    
    func updateSlider() {
        podcastSlider.value = Float(audioPlayer!.currentTime)
    }
    
    
}
