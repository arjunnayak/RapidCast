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
        
        //this gets the top 25 podcast channels for each category as NSURLS
        let iTunesLinks : [NSURL] = iTunesHelper.getiTunesLinksFromRSS(categories)
        
        var finalPlaylist : [String : [Podcast]] = [:]
        
        var totalPodcastCount = 0
        let expectedPodcastCount = 3*iTunesLinks.count
        
        for(var categoryCount = 0; categoryCount < iTunesLinks.count; categoryCount++) {

            let categoryCountInternal = categoryCount
            
            //make the http request, parses JSON, and returns list of Podcast URLS
            RequestHelper.makeRequestForLookupID(iTunesLinks[categoryCount]) { savedIDs in

                //gets iTunes URLS
                let lookupURLs : [NSURL] = iTunesHelper.getiTunesLookupURLs(savedIDs)
                
                //let channelCount = 0
                var podcastPlaylistPerCategory : [Podcast] = []
                for(var channelCount = 0;  channelCount < lookupURLs.count; channelCount++) {
                    //get feed URL containing XML
                    RequestHelper.makeRequestForFeedURL(lookupURLs[channelCount]) { feedURL in

                        print("feed URL: \(feedURL)")
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
                        } else {
                            finalPlaylist[categories[categoryCountInternal]] = podcastPlaylistPerCategory
                        }
                    }

                }
            }
        }
    }
}
