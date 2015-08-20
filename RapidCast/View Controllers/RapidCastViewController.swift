//
//  RapidCastViewController.swift
//  RapidCast
//
//  Created by Arjun Nayak on 7/20/15.
//  Copyright (c) 2015 Arjun Nayak. All rights reserved.
//

import UIKit
import RealmSwift

class RapidCastViewController: UIViewController {
    
    var chosenCategories : ChosenCategories = ChosenCategories()
    
    var categories: [String] = []
    
    var finalPlaylist : [String : [Podcast]] = [:]
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    @IBOutlet weak var noteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //self.noteLabel.lineBreakMode = .ByWordWrapping
        self.noteLabel.numberOfLines = 2
        self.waitingLabel.hidden = true
        
        let realm = Realm()
        
        if let get = realm.objects(ChosenCategories).last {
            self.chosenCategories = get
            //println("realm categories \(get.categoriesToStore.count)")
            
            for cat in self.chosenCategories.categoriesToStore {
                categories.append(cat.value)
            }
            
            //println(categories)
        }
        
        rapidCastButton.layer.borderColor = UIColor.whiteColor().CGColor

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)  
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.waitingLabel.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                    println("segue error")
            }
            
        }
    }
    
    func generateContent() {
        if self.categories.count > 0 {
            
            
            ContentGenerator.generate(categories) { finalPlaylist in //final playlist created
                self.finalPlaylist = finalPlaylist
                
                dispatch_async(dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("RapidCast", sender: self)
                        //print("should segue NOW")
                    
                    
                        self.spinner.stopAnimating()
                    
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                }
                
                
            }
        }
    }
    
    //MARK: UI Elements/Functionality
    
    @IBOutlet weak var waitingLabel: UILabel!
    @IBOutlet weak var rapidCastButton: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) { }
    
    @IBAction func rapidCast(sender: AnyObject) {
        self.spinner.startAnimating()
        self.waitingLabel.hidden = false
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        generateContent()
    }
    
    @IBAction func currentPlaylist(sender: AnyObject) {
        self.performSegueWithIdentifier("ShowCurrentPlaylist", sender: self)
    }
}