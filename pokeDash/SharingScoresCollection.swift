//
//  SharingScoresCollection.swift
//  pokeDash
//
//  Created by Prism Student on 2020-02-15.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//  These classes are built from previous assignments involving Fruit
//

import Foundation

class SharingScoresCollection {
    static let sharedScoresCollection = SharingScoresCollection()
    let fileName = "scores.archive"
    private let rootKey = "rootKey"
    var scoresCollection : ScoresCollection?
    func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(
 
            FileManager.SearchPathDirectory.documentDirectory,
            FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory = paths[0] as NSString
        return documentsDirectory.appendingPathComponent(fileName) as String
    }
    func loadScoresCollection(){
        print("loadScoresCollection  ...starting")
        let filePath = self.dataFilePath()
        if (FileManager.default.fileExists(atPath: filePath)) { let data = NSMutableData(contentsOfFile: filePath)!
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
            SharingScoresCollection.sharedScoresCollection.scoresCollection = unarchiver.decodeObject(forKey: rootKey) as? ScoresCollection
            unarchiver.finishDecoding()
        }
    }
    func saveScoresCollection(){
        let filePath = self.dataFilePath()
        print("saving the data")
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(SharingScoresCollection.sharedScoresCollection.scoresCollection, forKey: rootKey)
        archiver.finishEncoding()
        data.write(toFile: filePath, atomically: true)
    }
} //Class
