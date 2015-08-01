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
    
    var title : String? //titleTerm
    var author: String? //authorTerm
    var url:  NSString?
    var duration: String?
    var image : UIImage?
    
    init() {
        
    }
    
    func printPodcast() {
        println("\(title) \(author) \(url) \(duration) \(image?.description)")
    }
}

