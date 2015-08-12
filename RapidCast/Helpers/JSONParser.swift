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
    
    static func parseForLookupID(dataFromRequest : NSString) -> [String] {
    
        var lookupIDs : [String] = []
        
        let dataFromString = dataFromRequest.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let json = JSON(data: dataFromString!)
        
        //grab 3 random numbers
        var randomIndexes : [Int] = []
        for i in (0...2) {
            randomIndexes.append(Int(arc4random_uniform(25)))
        }
        
        let entryArray = json["feed"]["entry"]
        
        //get the 3 podcast channel ids for the generated random indexes
        for index  in randomIndexes {
            let id = json["feed"]["entry"][index]["id"]["attributes"]["im:id"].stringValue
            lookupIDs.append(id)
        }
        
        return lookupIDs
        
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
