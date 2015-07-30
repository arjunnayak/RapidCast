//
//  JSONParser.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/22/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONParser {
    
    static func parseForLookupID(dataFromRequest : NSString) -> String {
    
        let dataFromString = dataFromRequest.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)

        let json = JSON(data: dataFromString!)
        let feed = json["feed"]["entry"]["id"]
        let id = feed["attributes"]["im:id"].string!
        return id
    }
    
    static func parseForFeedURL(dataFromRequest: NSString) -> String {
        
        let dataFromString = dataFromRequest.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        let json = JSON(data: dataFromString!) //gets here successfully!
        let results = json["results"]
        let resultsAttributes = results[0]
        let feedURL = resultsAttributes["feedUrl"].stringValue
        return feedURL
    }
}
