//
//  AudioControlsView.swift
//  RapidCast
//
//  Created by Arjun Nayak on 4/18/16.
//  Copyright © 2016 Arjun Nayak. All rights reserved.
//

import Foundation
import UIKit

class AudioControlsView : UIView {
    
    static let sharedInstance = AudioControlsView()
    var titleLabel : UILabel
    
    init() {
        print("audio controls view singleton init called")
        let screenSize = UIScreen.mainScreen().bounds.size
        self.titleLabel = UILabel.init(frame: CGRectMake(10, 10, 50, 20))
        super.init(frame: CGRectMake(0, screenSize.height - 75, screenSize.width, 75))
        self.backgroundColor = UIColor.grayColor()
        self.titleLabel.text = "hello"
        addSubview(self.titleLabel)
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
    }

    required init?(coder aDecoder: NSCoder) {
        print("audio controls view nscoder init called")
        self.titleLabel = UILabel.init(frame: CGRectMake(10, 10, 50, 20))
        super.init(coder: aDecoder)
    }
    
    func setContents(podcast: Podcast) {
        print("set contents: \(podcast.title)")
        self.titleLabel.text = podcast.title
        showView()
    }
    
    func showView() {
        print("show audio controls view")
        self.hidden = false;
    }
    
    func hideView() {
        print("hide audio controls view")
        self.hidden = true;
    }
}
