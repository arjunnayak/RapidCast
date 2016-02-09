//
//  Category.swift
//  RapidCast
//
//  Created by Arjun Nayak on 2/7/16.
//  Copyright © 2016 Arjun Nayak. All rights reserved.
//

import Foundation
import UIKit

class Category {
    
    var name : String
    var image : UIImage?
    var isSelected : Bool?
    var podcasts : [Podcast]?
    
    init(name: String) {
        self.name = name
    }
    
    init(name: String, image: UIImage, isSelected: Bool) {
        self.name = name
        self.image = image
        self.isSelected = isSelected
    }
    
    convenience init(name: String, podcasts: [Podcast]) {
        self.init(name: name)
        self.podcasts = podcasts
    }
}