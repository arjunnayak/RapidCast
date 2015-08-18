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
    
    var podcastsToStore : SavedPodcasts = SavedPodcasts()
    
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
        
        if let getCategories = realm.objects(ChosenCategories).last {
            self.chosenCategories = getCategories
            //println("realm categories \(get.categoriesToStore.count)")
            
            for cat in self.chosenCategories.categoriesToStore {
                categories.append(cat.value)
            }
            
            //println(categories)
        }
        
        if let getSavedPodcasts = realm.objects(SavedPodcasts).last?.storedPodcasts {
            self.podcastsToStore.storedPodcasts = getSavedPodcasts
            
            for (category, podcasts) in getSavedPodcasts {
                
                var swiftPodcasts : [Podcast] = []
                for rPod in podcasts {

                    swiftPodcasts.append(Podcast(title: rPod.title, author: rPod.author, url: rPod.url, image: UIImage(data: NSData(contentsOfURL: NSURL(string: rPod.imageString)!)!)!))
                }
                self.finalPlaylist[category] = swiftPodcasts
                println("playlist from realm: \(finalPlaylist)")
            }
        }
        
        
        //println("realm categories object: \(self.chosenCategories.categoriesToStore)")
        
        rapidCastButton.layer.borderColor = UIColor.whiteColor().CGColor
        //self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
        
        
        //make podcastsToStore = finalPlaylist
        
        for (category, podcasts) in finalPlaylist { //creates podcast queue of podcasts
            
            var arrOfRealmPodcasts = List<RealmPodcast>()
            for podcast in podcasts {
                var rPodcast = RealmPodcast()
                rPodcast.title = podcast.title!
                rPodcast.author = podcast.author!
                rPodcast.url = podcast.url as! String
                //rPodcast.imageString = podcast.image.
                arrOfRealmPodcasts.append(rPodcast)
            }
            
            podcastsToStore.storedPodcasts[category] = arrOfRealmPodcasts
        }
        
        let realm = Realm()
        realm.write {
            realm.add(self.podcastsToStore, update: false)
            self.performSegueWithIdentifier("RapidCast", sender: self)
        }
    }
    
    @IBAction func currentPlaylist(sender: AnyObject) {
        self.performSegueWithIdentifier("ShowCurrentPlaylist", sender: self)
    }
}