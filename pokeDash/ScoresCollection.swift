//
//  ScoresCollection.swift
//  pokeDash
//
//  Created by Prism Student on 2020-04-16.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import Foundation
import UIKit
class ScoresCollection: NSObject, NSCoding {
    static var collection = [Scores]() // a collection is an array of scores
    static var current:Int = 0 // the current scores in the collection (to be shown in thescene)

    let collectionKey = "collectionKey"
    let currentKey = "currentKey"

    // MARK: - NSCoding methods
    override init(){
        super.init()
        //setup()
    }
    
    //add function
    func add(name: String, score: String){
        let score = Scores(name: name, score: score)
        ScoresCollection.collection.append(score!)
    }
    
    //sort the collection
    func customSort(){
        //var largestScore = 0
        if (ScoresCollection.collection.count > 1){
            for i in 0...ScoresCollection.collection.count - 2{
                for x in 0...ScoresCollection.collection.count - i - 2{
                    if (Int(ScoresCollection.collection[x].score)! < Int(ScoresCollection.collection[x+1].score)!){
                        ScoresCollection.collection.swapAt(x,x+1)
                    }
                }
            }
        }
    }
    
    //getter functions
    func getName() -> String{
        let scores = ScoresCollection.collection[ScoresCollection.current]
        return scores.name
    }
    func getScore() -> String{
        let scores = ScoresCollection.collection[ScoresCollection.current]
        return scores.score
    }
    
    func getCurrentIndex() -> Int {
        return ScoresCollection.current
    }
    func getCurrentScore() -> Scores {
        let scores = ScoresCollection.collection[ScoresCollection.current]
        return scores
    }
    
    //setter functions
    func setCurrentIndex(to index: Int){
        ScoresCollection.current = index
    }
    
    required convenience init?(coder decoder: NSCoder) {
        self.init()
        ScoresCollection.collection = (decoder.decodeObject(forKey: collectionKey) as? [Scores])!
        ScoresCollection.current = (decoder.decodeInteger(forKey: currentKey))
    }

    func clearAll(){
        ScoresCollection.collection.removeAll()
    }
    
    func encode(with acoder: NSCoder) {
        acoder.encode(ScoresCollection.collection, forKey: collectionKey)
        acoder.encode(ScoresCollection.current, forKey: currentKey)
    }
 // Mark: - Helpers
}

