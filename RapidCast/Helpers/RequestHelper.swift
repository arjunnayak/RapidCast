//
//  RequestHelper.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/22/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation

class RequestHelper {
    
    static func makeRequestForLookupID(url: NSURL, completionBlock: [String] -> Void) {
        var returningID : [String] = []
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            if let workingData = data {
                let responseString = NSString(data: workingData, encoding: NSUTF8StringEncoding)!
                returningID = JSONParser.parseForLookupID(responseString)
                completionBlock(returningID)
            } else {
                print("LookupID request for url: \(url) failed")
            }
        }
        task.resume()
    }

    static func makeRequestForFeedURL(url: NSURL, completionBlock: NSURL throws -> Void) {
        var returningLink = NSURL(string: "")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            if let workingData = data {
                print(String(format: "Feed url file size is : %.2f KB", Float(workingData.length)/Float(1024.0)));
                let responseString = NSString(data: workingData, encoding: NSUTF8StringEncoding)!
                returningLink = NSURL(string: JSONParser.parseForFeedURL(responseString))!
                try! completionBlock(returningLink!)
            } else {
                print("Feed URL request for url: \(url) failed")
            }
        }
        task.resume()
    }
}

