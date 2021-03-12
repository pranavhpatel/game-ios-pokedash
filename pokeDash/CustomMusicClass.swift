//
//  CustomMusicClass.swift
//  Utilized here, made in previous assignment: pate0910_a5
//
//  Created by Prism Student on 2020-03-23.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

private let MusicInstances = CustomMusicClass()

open class CustomMusicClass {
    
    // 2 objects so they dont override each other when multiple sounds playing
    var musicPlayer: AVAudioPlayer!
    var soundPlayer: AVAudioPlayer!

    open class func sharedInstance() -> CustomMusicClass {
        return MusicInstances
    }

    // function to start music
    open func playMusic(_ fileName: String, withExtension type: String = "") {
        if let url = Bundle.main.url(forResource: fileName, withExtension: type) {
            musicPlayer = try? AVAudioPlayer(contentsOf: url)
            musicPlayer.numberOfLoops = -1
            musicPlayer.prepareToPlay()
            musicPlayer.play()
        }
    }

    // function to stop music playing if music is playing
    open func stopMusic() {
        if musicPlayer != nil && musicPlayer!.isPlaying {
            musicPlayer.currentTime = 0
            musicPlayer.stop()
        }
    }
    
    // function to only play short 1 time sounds
    open func playSound(_ fileName: String, withExtension type: String = "") {
        if let url = Bundle.main.url(forResource: fileName, withExtension: type) {
            soundPlayer = try? AVAudioPlayer(contentsOf: url)
            soundPlayer.numberOfLoops = 1
            soundPlayer.prepareToPlay()
            soundPlayer.play()
        }
    }
}
