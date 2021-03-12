//
//  HighScoreViewController.swift
//  pokeDash
//
//  Created by Prism Student on 2020-04-15.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//  Background source: https://giphy.com/gifs/wallpaper-wallpapers-d2jhRkVSJy1ffcPu/media

import UIKit

class HighScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var leaderboardImage: UIImageView!
    
    
    override func viewDidLoad() {
        _ = SharingScoresCollection()
        SharingScoresCollection.sharedScoresCollection.scoresCollection = ScoresCollection()
        let theSharedCollection = SharingScoresCollection.sharedScoresCollection.scoresCollection
        //theSharedCollection!.clearAll()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let setHeight = CGFloat(50) //change here for table height manual override
        tableView.rowHeight = setHeight;
        // Do any additional setup after loading the view.
        SharingScoresCollection.sharedScoresCollection.loadScoresCollection() // un-archive data
        theSharedCollection?.customSort()
        tableView.reloadData()
        self.leaderboardImage.loadGif(name: "leaderGIF")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return ScoresCollection.collection.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        _ = SharingScoresCollection()
        SharingScoresCollection.sharedScoresCollection.scoresCollection = ScoresCollection()
        let theSharedCollection = SharingScoresCollection.sharedScoresCollection.scoresCollection
        //theSharedCollection?.customSort()
        let cell = tableView.dequeueReusableCell(withIdentifier: "customScoreCell") as! CustomLeaderboardCell
        theSharedCollection!.setCurrentIndex(to: indexPath.row)
        cell.nameLabel.text = theSharedCollection!.getName()
        cell.secondsLabel.text = theSharedCollection?.getScore()
        return cell
    }
    
    
    @IBAction func back2Menu(_ sender: Any) {
        self.dismiss(animated: true)
        //self.performSegue(withIdentifier: "Leaderboard2Menu", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
