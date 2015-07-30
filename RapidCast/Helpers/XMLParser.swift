//
//  XMLParser.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/24/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation

class XMLParser : NSObject, NSXMLParserDelegate {
    
    var parser : NSXMLParser?
    var feedURL : NSURL
    var podcastArray = [Podcast]()
    var podcastCount : Int
    
    init(feedURL : NSURL) {
        self.feedURL = feedURL
        self.podcastCount = 0
    }
    
    func beginParse() -> [Podcast] {
        parser = NSXMLParser(contentsOfURL: self.feedURL)
        parser?.delegate = self
        parser?.parse()
        return podcastArray
    }
    
    // MARK: - Parser delegates
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName: String?, attributes: [NSObject : AnyObject]) {
        
        if(self.podcastCount < 3) {
            if(elementName == "enclosure") {
                podcastArray.append(Podcast(mp3: attributes["url"] as! NSString))
                podcastCount++
            }
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters: String?) {
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName: String?) {
        
    }
}

