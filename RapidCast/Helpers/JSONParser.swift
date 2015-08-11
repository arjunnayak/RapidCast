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
        var lookupID = ""
        let json = JSON(data: dataFromString!)
        let id = json["feed"]["entry"][0]["id"]["attributes"]["im:id"]
        return id.stringValue
        
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
