//
//  SKPodcastPlayerViewController.swift
//  RapidCast
//
//  Created by Arjun Nayak on 4/16/16.
//  Copyright © 2016 Arjun Nayak. All rights reserved.
//

import Foundation
import StreamingKit
import UIKit
import AVFoundation

class SKPodcastPlayerViewController: UIViewController {
    
    var selectedPodcast : Podcast!
    let player = AudioPlayer.sharedInstance
    let audioControls = AudioControlsView.sharedInstance
    
    override func viewDidLoad() {
        player.play(selectedPodcast.url as! String)
        audioControls.setContents(selectedPodcast)
    }
    
    override func viewDidAppear(animated: Bool) {
        let audioControls = AudioControlsView.sharedInstance
        audioControls.hideView()
    }
}
