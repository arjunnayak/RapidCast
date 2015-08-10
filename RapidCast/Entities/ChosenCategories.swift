//
//  ChosenCategories.swift
//  RapidCast
//
//  Created by Arjun Nayak on 8/7/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation
import RealmSwift

class ChosenCategories : Object {
    
    dynamic var categoriesToStore : List<RealmCategory> = List<RealmCategory>()
    dynamic var _myID = "0"
    
//    override class func primaryKey() -> String {
//        return _myID
//    }


}