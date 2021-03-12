//
//  MainMenuViewController.swift
//  pokeDash
//
//  Created by Prism Student on 2020-04-15.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//  Background GIF source: https://giphy.com/gifs/pokemon-rse-exVPzbtdASOTS
//  Music source: https://downloads.khinsider.com/game-soundtracks/album/pokemon-original-game-soundtrack
//  https://freemusicarchive.org/music/BoxCat_Games
//  
//

import Foundation
import UIKit

/*
 Nice animated launch screen then display main menu of the game
 */
class MenuViewController: UIViewController {
    
    @IBOutlet weak var backGIF: UIImageView!
    @IBOutlet weak var leaderboardButton: UIButton!
    @IBOutlet weak var exploreButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    
    let arImage = UIImageView(image: UIImage(named: "PokeDash")!)
    let splashView = UIView()
    let musicOn = UIImage(named: "on")
    let musicOff = UIImage(named: "OFF")
    var musicPlayer = CustomMusicClass.sharedInstance()
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.backGIF.loadGif(name: "menuGIF")
        if (MusicInstance.musicStatus == false){
            musicButton.setImage(musicOff, for: .normal)
        }
        SharingScoresCollection.sharedScoresCollection.loadScoresCollection() // un-archive data
    }
    
    @IBAction func toggleMusic(_ sender: Any){
        if (MusicInstance.musicStatus == true){
            MusicInstance.musicStatus = false
            musicPlayer.stopMusic()
            musicButton.setImage(musicOff, for: .normal)
        }
        else{
            MusicInstance.musicStatus = true
            musicPlayer.playMusic("menuMusic.mp3")
            musicButton.setImage(musicOn, for: .normal)
        }
        
    }
    @IBAction func showTable(_ sender: Any){
        self.performSegue(withIdentifier: "TableViewIdentifier", sender: self)
    }
    @IBAction func showScores(_ sender: Any){
        self.performSegue(withIdentifier: "LeaderboardIdentifier", sender: self)
    }
}
