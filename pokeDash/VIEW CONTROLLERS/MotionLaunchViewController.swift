//
//  MotionLaunchViewController.swift
//  pokeDash
//
//  Created by Prism Student on 2020-04-16.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import Foundation
import UIKit

/*
 Nice animated launch screen then display main menu of the game
 */
class MotionLaunchViewController: UIViewController {
    
    let arImage = UIImageView(image: UIImage(named: "PokeDash")!)
    let splashView = UIView()
    var musicPlayer = CustomMusicClass.sharedInstance()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // clear any opened views
        
        let black = CGFloat(0)
        let alpha = CGFloat(1)
        let x0 = CGFloat(0)
        let y0 = CGFloat(0)
        let picOffset = CGFloat(100)
        let picSquare = CGFloat(200)
        self.musicPlayer.playMusic("menuMusic.mp3")
        splashView.backgroundColor = UIColor(red: black, green: black, blue: black, alpha: alpha)
        view.addSubview(splashView)
        splashView.frame = CGRect(x: x0, y: y0, width: view.bounds.width, height: view.bounds.height)
        arImage.contentMode = .scaleAspectFit
        splashView.addSubview(arImage)
        arImage.frame = CGRect(x: splashView.frame.midX - picOffset, y: splashView.frame.midY - picOffset, width: picSquare, height: picSquare)
    }
    
    func scaleDownAnimation(){
        let duration = TimeInterval(1) //seconds
        let scale = CGFloat(0.5)
        UIView.animate(withDuration: duration, animations: {
            self.arImage.transform = CGAffineTransform(scaleX: scale, y: scale)
        }) { ( success ) in
            self.scaleUpAnimation()
        }
    }
    
    func scaleUpAnimation(){
        let wDure = TimeInterval(1)
        let delay = TimeInterval(0.2)
        let scale = CGFloat(15)
        UIView.animate(withDuration: wDure, delay: delay, options: .curveEaseIn, animations: {
            self.arImage.transform = CGAffineTransform(scaleX: scale, y: scale)
        }) { (success ) in
            self.splashView.removeFromSuperview()
            self.performSegue(withIdentifier: "startMenu", sender: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.scaleDownAnimation()
    }
}
