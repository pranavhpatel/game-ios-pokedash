//
//  Pokemon.swift
//  pokeDash
//
//  Created by Prism Student on 2020-02-15.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//  These classes are built from previous assignments involving Fruit
//

import Foundation
import UIKit
import os.log
    class Pokemon: NSObject, NSCoding {
        //let pokemonImage : UIImage
        let pokemonName : String
        var type1 : String
        var type2 : String
        var moreInfo: String
 
        struct PropertyKey {
            //static let pokemonImage = "pokemonImage"
            static let pokemonName = "pokemonName"
            static let type1 = "type1"
            static let type2 = "type2"
            static let moreInfo = "moreInfo"
        }
        func encode(with aCoder: NSCoder) {
            aCoder.encode(pokemonName, forKey: PropertyKey.pokemonName)
            //aCoder.encode(pokemonImage, forKey: PropertyKey.pokemonImage)
            aCoder.encode(type1, forKey: PropertyKey.type1)
            aCoder.encode(type2, forKey: PropertyKey.type2)
            aCoder.encode(moreInfo, forKey: PropertyKey.moreInfo)
        }
        
        required convenience init?(coder aDecoder: NSCoder) {
            // The name is required. If we cannot decode a name string, the initializer should fail.
            guard let nameDecoded = aDecoder.decodeObject(
                forKey: PropertyKey.pokemonName) as? String else {
                    os_log("Unable to decode the name for pokemon.",
                        log: OSLog.default, type: .debug)
                    return nil
            }
            guard let type1Decoded = aDecoder.decodeObject(
                forKey: PropertyKey.type1) as? String else {
                    os_log("Unable to decode the name for type1.",
                        log: OSLog.default, type: .debug)
                    return nil
            }
            guard let type2Decoded = aDecoder.decodeObject(
                forKey: PropertyKey.type2) as? String else {
                    os_log("Unable to decode the name for type2.",
                        log: OSLog.default, type: .debug)
                    return nil
            }
            guard let moreInfoDecoded = aDecoder.decodeObject(
                forKey: PropertyKey.moreInfo) as? String else {
                    os_log("Unable to decode the name for moreInfo.",
                        log: OSLog.default, type: .debug)
                    return nil
            }
            // Because photo is an optional property of Meal, just use conditional cast.
        //let imageDecoded = (aDecoder.decodeObject(forKey: PropertyKey.pokemonImage) as? UIImage)!

            // Must call designated initializer.
            self.init(pokemonName: nameDecoded , type1: type1Decoded , type2: type2Decoded, moreInfo: moreInfoDecoded)
        }
    
        init?(pokemonName: String, type1: String, type2: String, moreInfo: String) {
            self.pokemonName = pokemonName
            //self.pokemonImage = pokemonImage
            self.type1 = type1
            self.type2 = type2
            self.moreInfo = moreInfo
        } //init?
}
