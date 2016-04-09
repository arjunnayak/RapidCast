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

    let gotPodcast = false
    
    
    static func getPodcast(feedURL : NSURL) -> Podcast {
        
        ////timing
        var startTime = CFAbsoluteTimeGetCurrent()
        
        
        let data = NSData(contentsOfURL: feedURL)
        var pod : Podcast?
        do {
            let xml = try GDataXMLDocument(data: data)
            let root = xml.rootElement()
            let channel = root.childAtIndex(0)
            let channelElements = channel.children()
            var image : UIImage?
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
                        let titleRef = gChild.elementsForName("title") as! [GDataXMLElement]
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
            ////timing
            let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
            print("xml parsing takes: \(Double(timeElapsed))")
        } catch _ {
            print("xml parser error")
        }
        
        if let pod = pod {
            return pod
        }
        else  {
            print("returned empty podcast")
            return Podcast()
        }
    }
}