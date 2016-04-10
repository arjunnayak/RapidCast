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
        
        var finalPlaylist : [String : [Podcast]] = [:]
        
        //this gets the top 25 podcast channels for each category as NSURLS
        let iTunesLinks : [NSURL] = iTunesHelper.getiTunesLinksFromRSS(categories)
        
        var totalPodcastCount = 0
        let expectedPodcastCount = 3*iTunesLinks.count
        
        for(var categoryCount = 0; categoryCount < iTunesLinks.count; categoryCount++) {

            let categoryCountInternal = categoryCount
            
            ////timing
            var startTime = CFAbsoluteTimeGetCurrent()
            
            //make the http request, parses JSON, and returns list of random lookup IDs for xml parsing
            RequestHelper.makeRequestForLookupID(iTunesLinks[categoryCount]) { savedIDs in
                
                ////timing
                var timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
                print("podcast request – lookup id takes: \(Double(timeElapsed))")
                
                //gets iTunes URLs
                let lookupURLs : [NSURL] = iTunesHelper.getiTunesLookupURLs(savedIDs)
                
                //let channelCount = 0
                var podcastPlaylistPerCategory : [Podcast] = []
                for(var channelCount = 0;  channelCount < lookupURLs.count; channelCount++) {
                    
                    ////timing
                    startTime = CFAbsoluteTimeGetCurrent()
                    
                    //get feed URL containing XML
                    RequestHelper.makeRequestForFeedURL(lookupURLs[channelCount]) { feedURL in
                        
                        ////timing
                        timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
                        print("podcast request – feed url takes: \(Double(timeElapsed))")
                        startTime = CFAbsoluteTimeGetCurrent()
                        
                        print("feed URL: \(feedURL)")
                        if(feedURL.absoluteString == "") {
                            print("feed url was invalid")
                            totalPodcastCount++
                        } else {
//                            let podcast = XMLParser.getPodcast(feedURL)
                            let podcast = XMLParser.getPodcastOno(feedURL)
                            if let pod = podcast {
                                pod.printPodcast()
                                podcastPlaylistPerCategory.append(pod)
                            } else {
                                //do something if we don't get back a podcast
                            }
                            totalPodcastCount++
                        }
                        if totalPodcastCount ==  expectedPodcastCount { //we've collected all podcasts
                            print("collected all podcasts")
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
