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
        
        let entryArray = json["feed"]["entry"]
        
        var randomIndexes = Set<Int>()
        while(randomIndexes.count != 3) {
            randomIndexes.insert(Int(arc4random_uniform(UInt32(entryArray.count))))
        }
        
        //get the 3 podcast channel ids for the generated random indexes
        for index in randomIndexes {
            let id = entryArray[index]["id"]["attributes"]["im:id"].stringValue
            print("json parser lookup id \(id)")
            if(id == "") {
                print("json parser id empty")
                print("json parser tried to acces \(index) in entry array \(entryArray)")
            }
            lookupIDs.append(id)
        }
        return lookupIDs
    }
    
    static func parseForFeedURL(dataFromRequest: NSString) -> String {
        
        let dataFromString = dataFromRequest.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let json = JSON(data: dataFromString!)
        let results = json["results"]
        let resultsAttributes = results[0]
        let feedURL = resultsAttributes["feedUrl"].stringValue
        return feedURL
    }
}
