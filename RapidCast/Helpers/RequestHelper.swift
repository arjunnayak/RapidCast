//
//  RequestHelper.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/22/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation

class RequestHelper {
    
    static func makeRequest(url: NSURL) {
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            var responseString = NSString(data: data, encoding: NSUTF8StringEncoding)!
            JSONParser.parse(responseString)
        }
        
        task.resume()
    }
}