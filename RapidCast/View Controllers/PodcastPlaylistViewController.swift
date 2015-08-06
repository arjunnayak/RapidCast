//
//  PodcastPlaylistViewController.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/15/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import UIKit
import AVFoundation

class PodcastPlaylistViewController: UITableViewController {

    var podcastPlaylist : [String : [Podcast]] = [:]
    
    var allPodcasts : [Podcast] = []
    
    var indexPodcasts = NSMutableArray()
    
    var categories : [Category] = []
    
    struct Category {
        var name : String
        var podcasts : [Podcast]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        for (category, podcasts) in podcastPlaylist { //creates podcast queue of podcasts
            
            categories.append(Category(name: category, podcasts: podcasts))
            
            for podcast in podcasts {
                allPodcasts.append(podcast)
                self.indexPodcasts.addObject(podcast as Podcast)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if(identifier == "PlayPodcast") {
                let playerViewController = segue.destinationViewController as! PodcastPlayerViewController
                let path = self.tableView.indexPathForSelectedRow()!
                let row = path.row
                playerViewController.currentIndex = row
                playerViewController.podcastPlaylist = self.podcastPlaylist
                
//                let section = path.section
//                let urlOptional = allPodcasts[row].url
//                if let url = urlOptional {
//                    playerViewController.player = AVPlayer(playerItem: AVPlayerItem(URL: NSURL(string: url as String)))
//                    playerViewController.player.play()
//                }
               
                //playerViewController.allPodcasts[path]
                
                //CURRENT THOUGHTS:
                //        create nsmutablearray of Podcasts, and so when a Podcast object in the table view is selected, search through the NSMutableArray using NSMutableArray.indexOfObject(Podcast selected) and set that to the current Index so that the queue functionality with currentIndex will work.

            }
        }
    }

    
    //CURRENT THOUGHTS:
    //        create nsmutablearray of Podcasts, and so when a Podcast object in the table view is selected, search through the NSMutableArray using NSMutableArray.indexOfObject(Podcast selected) and set that to the current Index so that the queue functionality with currentIndex will work.

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return categories.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories[section].podcasts.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> PodcastTableViewCell {
        let podcast = categories[indexPath.section].podcasts[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PodcastCell", forIndexPath: indexPath) as! PodcastTableViewCell
        
        cell.podcast = podcast
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].name
    }

//    func animateTable() {
//        tableView.reloadData()
//        
//        let cells = tableView.visibleCells()
//        let tableHeight: CGFloat = tableView.bounds.size.height
//        
//        for i in cells {
//            let cell: UITableViewCell = i as UITableViewCell
//            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
//        }
//        
//        var index = 0
//        
//        for a in cells {
//            let cell: UITableViewCell = a as UITableViewCell
//            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
//                cell.transform = CGAffineTransformMakeTranslation(0, 0);
//                }, completion: nil)
//            
//            index += 1
//        }
//    }


}

