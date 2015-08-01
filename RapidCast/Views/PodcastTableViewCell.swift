//
//  PodcastTableViewCell.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/16/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import UIKit

class PodcastTableViewCell: UITableViewCell {

    @IBOutlet weak var coverArt: UIImageView!
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var podcastChannel: UILabel!
    @IBOutlet weak var duration: UILabel!
    var track: NSObject? = NSObject()

    //IMPORTANT: NEED TO HANDLE WHEN PODCAST ATTRIBUTES TURN UP NIL
        //EXAMPLE: IF IMAGE(MEDIA:THUMBNAIL) == NIL, THEN GIVE IT SAMPLE IMAGE
    
    /*
    var podcast: Podcast? {
        didSet {
            if let podcast = podcast, coverArt = coverArt, episodeTitle = episodeTitle, podcastChannel = podcastChannel, duration = duration, track = track {
                
                self.coverArt.image = podcast.coverArt
                self.episodeTitle.text = podcast.episodeTitle
                self.podcastChannel.text = podcast.podcastChannel
                self.duration.text = podcast.duration
                self.track = podcast.mp3
            }
        }
    }
    */

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
