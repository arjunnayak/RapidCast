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
    var imageStr : String?
    var imageSaved : UIImage?
    
    init() {}
    
    func printPodcast() {
        print("-----Printing Podcast------")
        print("title:\(title) author:\(author) url:\(url) duration:\(duration) image:\(imageStr) \n")
    }
    
    convenience init(title : String, author: String, url: NSString, image: String) {
        self.init()
        self.title = title
        self.author = author
        self.url = url
        self.imageStr = image
    }
}

