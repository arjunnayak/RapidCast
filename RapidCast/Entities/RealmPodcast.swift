//
//  RealmPodcast.swift
//  RapidCast
//
//  Created by Arjun Nayak on 8/18/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation
import RealmSwift

class RealmPodcast : Object {
    
    dynamic var title : String = ""
    dynamic var author : String = ""
    dynamic var url : String = ""
    dynamic var imageString : String = ""
    
}