//
//  iTunesHelper.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/15/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation

class iTunesHelper {
    
    static func searchItunesFor(searchTerm: String) {
        
        // The iTunes API wants multiple terms separated by + symbols, so replace spaces with + signs
        var itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        // Now escape anything else that isn't URL-friendly
        var escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        var urlPath = "https://itunes.apple.com/search?term=\(escapedSearchTerm)&media=software"
        var url: NSURL! = NSURL(string: urlPath)
        var request: NSURLRequest? = NSURLRequest(URL: url!)
        var connection: NSURLConnection? = NSURLConnection(request: request!, delegate: self, startImmediately: false)
        
        println("Search iTunes API at URL \(url)")
        
        connection!.start()
    }
}
