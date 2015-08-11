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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = Realm()
        
        if let get = realm.objects(ChosenCategories).last {
            self.chosenCategories = get
            println("realm categories \(get.categoriesToStore.count)")
            
            for cat in self.chosenCategories.categoriesToStore {
                categories.append(cat.value)
            }
            
            println(categories)
        }
        
        
        //println("realm categories object: \(self.chosenCategories.categoriesToStore)")
        
        rapidCastButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
                case "RapidCast", "ShowCurrentPlaylist":
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
//                dispatch_async(dispatch_get_main_queue(), ^{[self performSegueWithIdentifier:@"login_success_new" sender:self];});
                
                dispatch_async(dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("RapidCast", sender: self)
                        print("should segue NOW")
                }
                
                
            }
        }
    }
    
    //MARK: UI Elements/Functionality
    
    @IBOutlet weak var rapidCastButton: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) { }
    
    @IBAction func rapidCast(sender: AnyObject) {
        generateContent()
    }
    
    @IBAction func currentPlaylist(sender: AnyObject) {
        self.performSegueWithIdentifier("ShowCurrentPlaylist", sender: self)
    }
}