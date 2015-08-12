//
//  RequestHelper.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/22/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation

class RequestHelper {
    
    private static var currentID : String =  ""
    private static var currentLink : NSURL? =  NSURL(string: "")
    
    static func makeRequestForLookupID(url: NSURL, completionBlock: [String] -> Void) {
        
        var returningID : [String] = []
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            var responseString = NSString(data: data, encoding: NSUTF8StringEncoding)!
            returningID = JSONParser.parseForLookupID(responseString)
            completionBlock(returningID)
        }
        task.resume()
    }


    static func makeRequestForFeedURL(url: NSURL, completionBlock: NSURL -> Void) {
            
        var returningLink = NSURL(string: "")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            var responseString = NSString(data: data, encoding: NSUTF8StringEncoding)!
            returningLink = NSURL(string: JSONParser.parseForFeedURL(responseString))!
            completionBlock(returningLink!)
        }
        task.resume()
    }

}

