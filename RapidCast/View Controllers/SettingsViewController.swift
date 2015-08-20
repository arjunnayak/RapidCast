//
//  SettingsViewController.swift
//  RapidCast
//
//  Created by Arjun Nayak on 8/18/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController : UITableViewController {
    
    
    @IBAction func icons8LinkPressed(sender: AnyObject) {
        
        if let url = NSURL(string: "https://icons8.com") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if(self.respondsToSelector(ed) {
//            self.edgesForExtendedLayout = UIRectEdge.None
//        }
    }
}