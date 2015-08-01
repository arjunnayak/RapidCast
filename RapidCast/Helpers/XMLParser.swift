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
    var podcastCount : Int
    var currentPodcast = Podcast()
    var currentParsedElement = String()
    var item = false
    
    init(feedURL : NSURL) {
        self.feedURL = feedURL
        self.podcastCount = 0
    }
    
    func beginParse() -> [Podcast] {
        parser = NSXMLParser(contentsOfURL: self.feedURL)
        println(self.feedURL)
        parser?.delegate = self
        parser?.parse()
        return podcastArray
    }
    
    // MARK: - Parser delegates
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName: String?, attributes: [NSObject : AnyObject]) {
        
        if(self.podcastCount < 3) {
            if(elementName == "item") {
                item = true
            }
            if (item){
                if(elementName == "title" || elementName == "itunes:author" || elementName == "itunes:duration") {
                    currentParsedElement = elementName
                }
                else if(elementName == "enclosure") { //url
                    currentPodcast.url = attributes["url"] as? NSString //work on this
                }
                else if(elementName == "media:thumbnail") { //image
                    currentPodcast.image = UIImage(data: NSData(contentsOfURL: NSURL(string: attributes["url"] as! String)!)!)!
                }
            }
            
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters: String?) {
        if(item) {
            switch (currentParsedElement) {
                case "title":
                    currentPodcast.title = foundCharacters! //title
                case "itunes:author":
                    currentPodcast.author = foundCharacters! //author
                case "itunes:duration":
                    currentPodcast.duration = foundCharacters! //duration
                default: break
            }
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName: String?) {
        if(item){
            switch (elementName) {
                case "title":
                    currentParsedElement = ""
                case "itunes:author":
                    currentParsedElement = ""
                case "itunes:duration":
                    currentParsedElement = ""
                default:
                    break
            }
            if(elementName == "item") {
                podcastArray.append(currentPodcast)
                currentPodcast.printPodcast()
                podcastCount++
                currentPodcast = Podcast() //reset
                item = false
            }
        }
    }
}