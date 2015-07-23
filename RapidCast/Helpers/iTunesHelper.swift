//
//  iTunesHelper.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/15/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation

class iTunesHelper {
    
    static var genres = [   "Arts" : "1301",
        "Comedy" : "1303",
        "Education" : "1304"
        //"" : "",
        //"" : "",
        //"" : "",
    ]
    
    static func getiTunesLinksFromRSS(categories: [String]) -> [NSURL] {
        var genreIDs = [String]()
        for category in categories {
            genreIDs.append(iTunesHelper.genres[category]!)
        }
        
        var iTunesLinks = [NSURL]()
        for (var i = 0; i < genreIDs.count; i++) {
            //get ids from rss link
            iTunesLinks.append(NSURL(string: "https://itunes.apple.com/us/rss/toppodcasts/limit=1/genre=\(genreIDs[i])/json")!)
        }
        return iTunesLinks
    }
    
    
    /*
    * @parm in the lookup ID from rss link generator
    */
    static func lookupItunesFor(lookupID: String) {
        
        var urlPath = "https://itunes.apple.com/lookup?id=\(lookupID)"
        var url: NSURL! = NSURL(string: urlPath)
        var request: NSURLRequest? = NSURLRequest(URL: url!)
        var connection: NSURLConnection? = NSURLConnection(request: request!, delegate: self, startImmediately: false)
        
        ///what do you do with this connection??
        println("Lookup iTunes API at URL \(url)")
        
        connection!.start()
    }
    
    static func getGenres() -> Dictionary<String, String> {
        return genres
    }
}