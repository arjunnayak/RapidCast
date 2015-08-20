//
//  XMLParser.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/24/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation
import UIKit

class XMLParser {

    var gotPodcast = false
    
    static func getPodcast(feedURL : NSURL) -> Podcast {
       // println(feedURL)
        
        var xml : GDataXMLDocument = GDataXMLDocument(data: NSData(contentsOfURL: feedURL), error: nil)
        var root = xml.rootElement()
        var channel = root.childAtIndex(0)
        var channelElements = channel.children()
        var image : UIImage?
        var pod : Podcast?
        
        var gotPodcast = false
        
        parsing: for child in channelElements { //goes through every element
            
            if let gChild = child as? GDataXMLElement {
                if(image == nil) {
                    if(gChild.name() == "itunes:image") {
                        if let imageRef = NSData(contentsOfURL: NSURL(string: gChild.attributeForName("href").stringValue())!) {
                            image = UIImage(data: imageRef)
                        }
                        else {
                            image = UIImage(named: "podcast icon.jpeg")
                        }
                    }
                }
                
                if(gChild.name() == "item") {
                    var titleRef = gChild.elementsForName("title") as! [GDataXMLElement]
                    var podcastAuthor = ""
                    if let authorRef = gChild.elementsForName("itunes:author") as? [GDataXMLElement] {
                        podcastAuthor = authorRef[0].stringValue()
                    }
                    var url = ""
                    if let enclosure = gChild.elementsForName("enclosure") as? [GDataXMLElement] {
                        url = enclosure[0].attributeForName("url").stringValue()
                        if(image == nil) {
                            image = UIImage(named: "podcast icon.jpeg")
                        }
                        pod = Podcast(title: titleRef[0].stringValue(), author: podcastAuthor, url: NSString(string: url), image: image!)
                        gotPodcast = true
                    }
                }
                
                if(gotPodcast) {
                    break parsing
                }
            }
        }
        if let pod = pod {
            return pod
        }
        else  {
            return Podcast()
        }
        
    }
    
}