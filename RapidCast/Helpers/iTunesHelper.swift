//
//  iTunesHelper.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/15/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation

class iTunesHelper {
    
    static func getiTunesLinksFromRSS(categories: [String]) -> [NSURL] {
        var genreIDs = [String]()
        for category in categories {
            genreIDs.append(iTunesHelper.genres[category]!)
        }
        
        var iTunesLinks = [NSURL]()
        for (var i = 0; i < genreIDs.count; i++) {
            //get ids from rss link
            iTunesLinks.append(NSURL(string: "https://itunes.apple.com/us/rss/toppodcasts/limit=25/genre=\(genreIDs[i])/json")!)
        }
        return iTunesLinks
    }
    
    
    /*
    * @parm in the lookup ID from rss link generator
    */
    static func getiTunesLookupURLs(lookupIDs: [String]) -> [NSURL] {
        
        var lookupURLs : [NSURL] = []
        for id in lookupIDs {
            lookupURLs.append(NSURL(string: "https://itunes.apple.com/lookup?id=\(id)")!)
        }
        return lookupURLs
    }
    
    static func getGenres() -> Dictionary<String, String> {
        return genres
    }
    
    private static let genres = [
        "Arts" : "1301",
        "Comedy" : "1303",
        "Education" : "1304",
        "Kids & Family" : "1305",
        "Health" : "1307",
        "TV & Film" : "1309",
        "Music" : "1310",
        "News & Politics" : "1311",
        "Science & Medicine" : "1315",
        "Sports & Recreation" : "1316",
        "Technology" : "1318",
        "Business" : "1321",
        "Games & Hobbies" : "1323",
        "Society & Culture" : "1324",
        "Government" : "1325"
    ]
    
}