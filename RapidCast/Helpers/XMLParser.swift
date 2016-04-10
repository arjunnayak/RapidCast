//
//  XMLParser.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/24/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation
import UIKit
import Ono

class XMLParser {

    let gotPodcast = false
    
    
    static func getPodcast(feedURL : NSURL) -> Podcast {
        ////timing
        let startTime = CFAbsoluteTimeGetCurrent()
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
                        print("gdata xml parsing - got podcast, breaking parsing")
                        break parsing
                    }
                }
            }
            ////timing
            let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
            print("gdata xml parsing takes: \(Double(timeElapsed))")
        } catch _ {
            print("gdata xml parser error")
        }
        
        if let pod = pod {
            return pod
        }
        else  {
            print("gdata returned empty podcast")
            return Podcast()
        }
    }
    
    
    static func getPodcastOno(feedURL : NSURL) -> Podcast? {
        ////timing
        let startTime = CFAbsoluteTimeGetCurrent()
        let data = NSData(contentsOfURL: feedURL)
        var pod : Podcast?
        do {
            let document = try ONOXMLDocument(data: data)
            let channel : ONOXMLElement = document.rootElement.children[0] as! ONOXMLElement
            var image = self.getImage(channel.firstChildWithTag("image"))
            if(image == nil) { //getImage could not find an image, set default image
                image = UIImage.init(named: "AppIcon")!
            }
            let channelElements = channel.children
            var gotPodcast = false
            parsing: for child in channelElements {
                if let oChild = child as? ONOXMLElement {
                    //print(oChild.tag)
                    if(oChild.tag == "item") {
                        //print("item: \(oChild)")
                        let title : ONOXMLElement = oChild.firstChildWithTag("title")
                        let author : ONOXMLElement = oChild.firstChildWithTag("itunes:author")
                        let enclosure : ONOXMLElement = oChild.firstChildWithTag("enclosure")
                        let url = enclosure.valueForAttribute("url") as! String
                        pod = Podcast(title: title.stringValue(), author: author.stringValue(), url: url, image: image!)
                        gotPodcast = true
                    }
                    if(gotPodcast) {
                        print("ono xml parsing - got podcast, breaking parsing")
                        break parsing
                    }
                }
            }
            ////timing
            let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
            print("gdata xml parsing takes: \(Double(timeElapsed))")
        } catch _ {
            print("ono xml parser error")
        }
        
        if let pod = pod {
            return pod
        }
        else  {
            print("gdata returned empty podcast")
            return nil
        }
    }
    
    static func getImage(element: ONOXMLElement) -> UIImage? {
        //element.tag is always "image"
        var image : UIImage?
        //print("getImage element: \(element)")
        if(!element.attributes.isEmpty) {
            //print("getImage itunes:image attributes \(element.attributes)")
            //print("getImage itunes:image href attribute: \(element.valueForAttribute("href"))")
            let urlStr = element.valueForAttribute("href") as! String
            print("getImage urlStr: \(urlStr)")
            image = UIImage.init(data: NSData.init(contentsOfURL: NSURL.init(string: urlStr)!)!)
        } else if(!element.children.isEmpty) {
            let urlElement = element.firstChildWithTag("url")
            print("getImage <image> url child: \(urlElement.stringValue())")
            image = UIImage.init(data: NSData.init(contentsOfURL: NSURL.init(string: urlElement.stringValue())!)!)!
        }
        if let img = image {
            return img
        } else {
            return nil
        }
    }
}

