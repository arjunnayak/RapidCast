//
//  PodcastTableViewCell.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/16/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import UIKit
import SDWebImage

class PodcastTableViewCell: UITableViewCell {

//    var title : String? //titleTerm
//    var author: String? //authorTerm
//    var url:  NSString?
//    var duration: String?
//    var image : UIImage?
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var duration: UILabel!

    //IMPORTANT: NEED TO HANDLE WHEN PODCAST ATTRIBUTES TURN UP NIL
        //EXAMPLE: IF IMAGE(MEDIA:THUMBNAIL) == NIL, THEN GIVE IT SAMPLE IMAGE
    
    
    var podcast: Podcast? {
        didSet {
            if let podcast = podcast {
                self.title.text = podcast.title
                self.author.text = podcast.author
                self.podcastImage.sd_setImageWithURL(NSURL.init(string: podcast.imageStr!), placeholderImage: UIImage.init(named: "appIcon"), completed: { (imageDownloaded, error2, SDImageCacheType, imageURL) -> Void in
                    podcast.imageSaved = imageDownloaded
                })
                //self.duration.text = podcast.duration
                let track = podcast.url
            }
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
