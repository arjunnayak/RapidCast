//
//  Podcast.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/16/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation
import UIKit

class Podcast {
    
    let episodeTitle : String = "" //titleTerm
    let podcastChannel: String = ""  //authorTerm
    let coverArt : UIImage = UIImage()
    let duration: String = ""
    let mp3:  NSString
    let genre: NSString = ""
    
    init(mp3 : NSString) {
        self.mp3 = mp3
    }
}

