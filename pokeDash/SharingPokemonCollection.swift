//
//  SharingPokemonCollection.swift
//  pokeDash
//
//  Created by Prism Student on 2020-02-15.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//  These classes are built from previous assignments involving Fruit
//

import Foundation

class SharingPokemonCollection {
    static let sharedPokemonCollection = SharingPokemonCollection()
    let fileName = "pokemon.archive"
    private let rootKey = "rootKey"
    var pokemonCollection : PokemonCollection?
    func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(
 
            FileManager.SearchPathDirectory.documentDirectory,
            FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory = paths[0] as NSString
        return documentsDirectory.appendingPathComponent(fileName) as String
    }
    func loadPokemonCollection(){
        print("loadPokemonCollection  ...starting")
        let filePath = self.dataFilePath()
        if (FileManager.default.fileExists(atPath: filePath)) { let data = NSMutableData(contentsOfFile: filePath)!
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
            SharingPokemonCollection.sharedPokemonCollection.pokemonCollection = unarchiver.decodeObject(forKey: rootKey) as? PokemonCollection
            unarchiver.finishDecoding()
        }
    }
    func savePokemonCollection(){
        let filePath = self.dataFilePath()
        print("saving the data")
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(SharingPokemonCollection.sharedPokemonCollection.pokemonCollection, forKey: rootKey)
        archiver.finishEncoding()
        data.write(toFile: filePath, atomically: true)
    }
} //Class
