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
    
    static func parse(dataFromRequest : NSString) {
    
        let json = JSON(dataFromRequest)
        
        //example:
        // let path = [1,"list",2,"name"]
        // let name = json[path].string

        
        println(json)
        //NOTE: CAN ACCESS JSON, JUST NOT ID YET, FIX THIS


    }
}
