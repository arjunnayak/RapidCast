//
//  RapidCastViewController.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/20/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import UIKit
import RealmSwift
import MBProgressHUD

class RapidCastViewController: UIViewController {
    
    var categories: [String] = []
    var finalPlaylist : [String : [Podcast]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.noteLabel.lineBreakMode = .ByWordWrapping
        self.noteLabel.numberOfLines = 2
        rapidCastButton.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    override func viewDidAppear(animated: Bool) {
        categories = NSUserDefaults.standardUserDefaults().objectForKey("chosen_categories") as! [String]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)  
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: Segue functionality
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch (identifier) {
                case "RapidCast":
                    let playlistController: PodcastPlaylistViewController = segue.destinationViewController as! PodcastPlaylistViewController
                    playlistController.podcastPlaylist = finalPlaylist
                case "ShowCurrentPlaylist":
                    let playlistController: PodcastPlaylistViewController = segue.destinationViewController as! PodcastPlaylistViewController
                    playlistController.podcastPlaylist = finalPlaylist
                default:
                    print("segue error")
            }
            
        }
    }
    
    func generateContent() {
        if self.categories.count > 0 {
            
//            let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//            
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
//                
//                ContentGenerator.generate(self.categories) { finalPlaylist in
//                    self.finalPlaylist = finalPlaylist
//                    dispatch_async(dispatch_get_main_queue()) {
//                        
//                        progressHUD.hide(true)
//                        self.performSegueWithIdentifier("RapidCast", sender: self)
//                    }
//                }
//            }
            
            let progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated:true)
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.01 * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue()) {
                
                ////timing
                let finalStartTime = CFAbsoluteTimeGetCurrent()
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> () in
                    ContentGenerator.generate(self.categories) { finalPlaylist in
                        self.finalPlaylist = finalPlaylist
                        
                        ////timing
                        let finalTimeElapsed = CFAbsoluteTimeGetCurrent() - finalStartTime
                        print("entire podcast process time: \(Double(finalTimeElapsed))")
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            progressHUD.hide(true)
                            self.performSegueWithIdentifier("RapidCast", sender: self)
                        }
                    }
                });
               
            }
        }
    }
    
    //MARK: UI Elements/Functionality
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var rapidCastButton: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) { }
    
    @IBAction func rapidCast(sender: AnyObject) {
        generateContent()
    }
    
    @IBAction func currentPlaylist(sender: AnyObject) {
        self.performSegueWithIdentifier("ShowCurrentPlaylist", sender: self)
    }
}