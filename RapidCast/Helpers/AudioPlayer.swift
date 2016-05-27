//
//  AudioPlayer.swift
//  RapidCast
//
//  Created by Arjun Nayak on 4/17/16.
//  Copyright © 2016 Arjun Nayak. All rights reserved.
//

import Foundation
import StreamingKit

public class AudioPlayer : NSObject {
    
    public var player : STKAudioPlayer!
    var queue : STKDataSource!
    
    static let sharedInstance = AudioPlayer()
    
    private override init() {}
    
    func play(url : String) {
        
        if (self.player.state == STKAudioPlayerState.Running) {
            self.player.stop()
        }
        
        player.play(url)
    }
    
    func pause() {
        self.player.pause()
    }
    
    func resume() {
        self.player.resume()
    }
    
    func getState() -> STKAudioPlayerState {
        return self.player.state
    }
    
    func setCurrentAudioTime(value: Double) {
        self.player.seekToTime(value)
    }
}
