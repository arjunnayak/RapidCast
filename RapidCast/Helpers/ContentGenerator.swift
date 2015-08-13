//
//  ContentGenerator.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/28/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation
import QuartzCore

class ContentGenerator {
    
    static func generate(categories: [String], completionBlock: [String : [Podcast]] -> Void) {
        
        
        var lookupIDs = [String]()
        var iTunesLinks : [NSURL] = iTunesHelper.getiTunesLinksFromRSS(categories)
        //this gets the top 25 podcast channels for each category
        
        var podcastPlaylist: [Podcast] = []
        
        var finalPlaylist : [String : [Podcast]] = [:]
        
        var totalPodcastCount = 0
        var expectedPodcastCount = 3*iTunesLinks.count
        
        var xmlParser : XMLParser?
        
        for(var categoryCount = 0; categoryCount < iTunesLinks.count; categoryCount++) {
            println(categoryCount)
            println(iTunesLinks[categoryCount])
            let categoryCountInternal = categoryCount
            
            RequestHelper.makeRequestForLookupID(iTunesLinks[categoryCount]) { savedIDs in //make the http request for the first category
                

                var lookupURLs : [NSURL] = iTunesHelper.getiTunesLookupURLs(savedIDs) //3 lookupUrls for podcast channels
                
                //var channelCount = 0
                var podcastPlaylistPerCategory : [Podcast] = []
                
                for(var channelCount = 0;  channelCount < lookupURLs.count; channelCount++) {

                    RequestHelper.makeRequestForFeedURL(lookupURLs[channelCount]) { feedURL in //got feedURL

                        println(feedURL)
                        if(feedURL == "") {
                            println("is this taking long?")
                            totalPodcastCount++
                        }
                        else {
                            var startXMLParse = CACurrentMediaTime()
                            xmlParser = XMLParser(feedURL: feedURL)
                            let podcast = xmlParser!.beginParse()
//                            if let pod = podcast {
                            var finishXMLParse = CACurrentMediaTime()
                            println("Request Finished for XML Parsing: \(finishXMLParse - startXMLParse)")
                            podcastPlaylistPerCategory.append(podcast!)
//                            }
                            //saves podcasts for each category to be appended later
                            totalPodcastCount++
                        }

                        if totalPodcastCount ==  expectedPodcastCount { //we've collected all podcasts
                            
                            finalPlaylist[categories[categoryCountInternal]] = podcastPlaylistPerCategory
                            completionBlock(finalPlaylist)
                        }
                        else {
                            finalPlaylist[categories[categoryCountInternal]] = podcastPlaylistPerCategory
                        }
                    }
                }
            }
        }
    }
}
