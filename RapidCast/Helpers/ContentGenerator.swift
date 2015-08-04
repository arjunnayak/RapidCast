//
//  ContentGenerator.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/28/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation

class ContentGenerator {
    
    static func generate(categories: [String], completionBlock: [String : [Podcast]] -> Void) {
        var counter = 0
        var lookupIDs = [String]()
        var iTunesLinks : [NSURL] = iTunesHelper.getiTunesLinksFromRSS(categories)
        //println(iTunesLinks.count)
        
        var podcastPlaylist: [Podcast] = []
        
        var finalPlaylist : [String : [Podcast]] = [:]
        
        
        for link in iTunesLinks {
            
            RequestHelper.makeRequestForLookupID(link) { savedID in //lookupID
                
                var lookupURL  = iTunesHelper.getiTunesLookupURLs(savedID)
                
                RequestHelper.makeRequestForFeedURL(lookupURL) { feedURL in //got feedURL
                    counter++
                    var xmlParser = XMLParser(feedURL: feedURL)
                    podcastPlaylist = xmlParser.beginParse()
                    println(counter)
                    
                    if counter ==  iTunesLinks.count {
                        finalPlaylist[categories[counter - 1]] = podcastPlaylist
                        completionBlock(finalPlaylist)
                    }
                    else {
                        finalPlaylist[categories[counter - 1]] = podcastPlaylist
                    }
                }
            }
        }
    }
}
