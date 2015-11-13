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
        
        var iTunesLinks : [NSURL] = iTunesHelper.getiTunesLinksFromRSS(categories)
        //this gets the top 25 podcast channels for each category
        
        var finalPlaylist : [String : [Podcast]] = [:]
        
        var totalPodcastCount = 0
        let expectedPodcastCount = 3*iTunesLinks.count
        
        for(var categoryCount = 0; categoryCount < iTunesLinks.count; categoryCount++) {

            let categoryCountInternal = categoryCount
            
            RequestHelper.makeRequestForLookupID(iTunesLinks[categoryCount]) { savedIDs in //make the http request for the first category

                var lookupURLs : [NSURL] = iTunesHelper.getiTunesLookupURLs(savedIDs) //3 lookupUrls for podcast channels
                
                //var channelCount = 0
                var podcastPlaylistPerCategory : [Podcast] = []
                
                for(var channelCount = 0;  channelCount < lookupURLs.count; channelCount++) {
                    

                    RequestHelper.makeRequestForFeedURL(lookupURLs[channelCount]) { feedURL in

                        //println(feedURL)
                        if(feedURL.absoluteString == "") {
                            totalPodcastCount++
                        }
                        else {
                            let podcast = XMLParser.getPodcast(feedURL)
                            podcast.printPodcast()
                            podcastPlaylistPerCategory.append(podcast)
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
