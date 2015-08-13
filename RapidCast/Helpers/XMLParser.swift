//
//  XMLParser.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/24/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation
import UIKit

class XMLParser : NSObject, NSXMLParserDelegate {
    
    var parser : NSXMLParser?
    
    var feedURL : NSURL
    var podcastArray = [Podcast]()
    //var podcastCount : Int
    
    var currentPodcast : Podcast?
    var currentParsedElement = ""
    var item = false
    var gotPodcast = false
    var mutableString = NSMutableString(string: "")
    
    init(feedURL : NSURL) {
        self.feedURL = feedURL
        if(feedURL == "") {
            println("error here")
        }
        self.gotPodcast = false
        //self.podcastCount = 0
    }
    
    func beginParse() -> Podcast? {
        parser = NSXMLParser(contentsOfURL: self.feedURL)
       // println(self.feedURL)
        parser?.delegate = self
        currentPodcast = Podcast()
        parser?.parse()
        return currentPodcast!
        //return podcastArray
    }
    
    // MARK: - Parser delegates
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName: String?, attributes: [NSObject : AnyObject]) {
        
        if(!gotPodcast) {
            if(elementName == "itunes:image") {
                
                //var img : String? = attributes["href"] as? String
                if attributes.isEmpty {
                    currentPodcast!.image = UIImage(named: "podcast icon.jpeg")
                }
                else if let img: AnyObject = attributes["href"] {
                    if(img as? String == "") {
                        currentPodcast!.image = UIImage(named: "podcast icon.jpeg")!
                    }
                    else {
                        var string = img as! String
                        var url = NSURL(string: string)
                        var image = UIImage()
                        if let nsdata = NSData(contentsOfURL: url!) {
                            image = UIImage(data: nsdata)!
                        }
                        else {
                            image = UIImage(named: "podcast icon.jpeg")!
                        }
                        currentPodcast!.image = image
                    }
                }
                else if let image : AnyObject = attributes["url"] {
                    var string = image as! String
                    var url = NSURL(string: string)
                    var nsdata = NSData(contentsOfURL: url!)
                    var image = UIImage(data: nsdata!)
                    currentPodcast!.image = image
                }
                else {
                    currentPodcast!.image = UIImage(contentsOfFile: "podcast icon.jpeg")
                }
            }
            else if(elementName == "item") {
                item = true
            }
            
            if (item){
                if(elementName == "title" || elementName == "itunes:author" || elementName == "itunes:duration") {
                    currentParsedElement = elementName
                }
                else if(elementName == "enclosure") { //url
                    currentPodcast?.url = attributes["url"] as? NSString //work on this
                    //gotPodcast = true
                }
            }
        }
        else {
            println("aborting parser")
            self.parser?.abortParsing()
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters: String?) {
        if(item) {
            switch (currentParsedElement) {
                case "title":
                    if(mutableString == "") {
                        mutableString = NSMutableString(string: foundCharacters!)
                    }
                    else {
                        mutableString.appendString(foundCharacters!)
                    }
                    currentPodcast!.title = mutableString as String
                case "itunes:author":
                    if(mutableString == "") {
                        mutableString = NSMutableString(string: foundCharacters!)
                    }
                    else {
                        mutableString.appendString(foundCharacters!)
                    }
                    currentPodcast!.author = mutableString as String
                case "itunes:duration":
                    if(mutableString == "") {
                        mutableString = NSMutableString(string: foundCharacters!)
                    }
                    else {
                        mutableString.appendString(foundCharacters!)
                    }
                    currentPodcast!.duration = mutableString as String
                default: break
            }
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName: String?) {
        if(!gotPodcast) {
            if(elementName == "item") {
                if let podcast = currentPodcast {
                    podcastArray.append(podcast)
                    gotPodcast = true
                    //item = true
                }
                else {
                    println("podcast turned out null")
                }
                
            }
        }
        if(item){
            switch (elementName) {
                case "title", "itunes:author", "itunes:duration":
                    currentParsedElement = ""
                    mutableString = ""
                default:
                    break
            }
        }
        
    }
}