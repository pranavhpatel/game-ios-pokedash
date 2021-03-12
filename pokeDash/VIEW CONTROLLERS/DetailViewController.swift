//
//  SecondViewController.swift
//  pokeDash
//
//  Created by Prism Student on 2020-02-27.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var type1Lable: UILabel!
    @IBOutlet weak var type2Lable: UILabel!
    @IBOutlet weak var moreInfoLable: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    let musicPlayer = CustomMusicClass.sharedInstance()

    override func viewDidLoad() {
        refresh()
        super.viewDidLoad()
    }
    
    var sharedPokemonCollection : PokemonCollection?
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
    }

    /*
     what ever the current collection is, this function will get the current data
     */
    func refresh(){
        _ = SharingPokemonCollection()
        SharingPokemonCollection.sharedPokemonCollection.pokemonCollection = PokemonCollection()
        let theSharedCollection = SharingPokemonCollection.sharedPokemonCollection.pokemonCollection
        self.detailImage.loadGif(name: "detailGIF")
        if (PokemonCollection.collection.count == 0){
            clear()
        }
        else{
            //let initialImage = theSharedCollection.getImage()
            //pokemonImage.image = initialImage
            pokemonImage.loadGif(name: theSharedCollection!.getName().lowercased())
            pokemonLabel.text = theSharedCollection!.getName()
            type1Lable.text = theSharedCollection!.gettype1()
            type2Lable.text = theSharedCollection?.gettype2()
            moreInfoLable.text = theSharedCollection?.getmoreInfo()
        }
        let roundness = CGFloat(10.0)
        pokemonLabel.layer.cornerRadius = roundness
        pokemonLabel.clipsToBounds = true
        type1Lable.layer.cornerRadius = roundness
        type1Lable.clipsToBounds = true
        type2Lable.layer.cornerRadius = roundness
        type2Lable.clipsToBounds = true
        moreInfoLable.layer.cornerRadius = roundness
        moreInfoLable.clipsToBounds = true
    }
    func clear(){
        pokemonImage.image = UIImage(named: "question")
        pokemonLabel.text = ""
        type1Lable.text = "0"
        type2Lable.text = "0"
        moreInfoLable.text = "NA"
    }
    
    @IBAction func back2List(_ sender: Any){
        self.dismiss(animated: true)
        //self.performSegue(withIdentifier: "Detail2Table", sender: self)
    }
    @IBAction func startGame(_ sender: Any){
        if (MusicInstance.musicStatus == true){
            musicPlayer.playMusic("dash.mp3")
        }
        self.performSegue(withIdentifier: "startGame", sender: self)
    }
}

