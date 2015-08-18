//
//  SavedPodcasts.swift
//  RapidCast
//
//  Created by Arjun Nayak on 8/18/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation
import RealmSwift

class SavedPodcasts : Object {
    
    dynamic var storedPodcasts : [String : List<RealmPodcast>] = [String: List<RealmPodcast>]()

}