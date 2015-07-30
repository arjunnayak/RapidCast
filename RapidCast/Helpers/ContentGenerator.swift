//
//  ContentGenerator.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/28/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation

class ContentGenerator {
    
    static func generate(categories: [String]) -> [Podcast] {
        
        var lookupIDs = [String]()
        var iTunesLinks : [NSURL] = iTunesHelper.getiTunesLinksFromRSS(categories)
        
        var podcastPlaylist = [Podcast]()
        
        for link in iTunesLinks {
            RequestHelper.makeRequestForLookupID(link) { savedID in //lookupID
                
                var lookupURL  = iTunesHelper.getiTunesLookupURLs(savedID)
                println(lookupURL)
                RequestHelper.makeRequestForFeedURL(lookupURL) { feedURL in //got feedURL
                    var xmlParser = XMLParser(feedURL: feedURL)
                    podcastPlaylist = xmlParser.beginParse()
                }
            }
        }
        
        return podcastPlaylist
    }
}
