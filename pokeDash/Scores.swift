//
//  Scores.swift
//  pokeDash
//
//  Created by Prism Student on 2020-04-16.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import Foundation
import UIKit
import os.log
class Scores: NSObject, NSCoding {
    let score : String
    let name : String

    struct PropertyKey {
        static let score = "score"
        static let name = "name"
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(score, forKey: PropertyKey.score)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let nameDecoded = aDecoder.decodeObject(
            forKey: PropertyKey.name) as? String else {
                os_log("Unable to decode the name.",
                    log: OSLog.default, type: .debug)
                return nil
        }
        guard let scoreDecoded = aDecoder.decodeObject(
            forKey: PropertyKey.score) as? String else {
                os_log("Unable to decode the score",
                    log: OSLog.default, type: .debug)
                return nil
        }

        // Must call designated initializer.
        self.init(name: nameDecoded, score: scoreDecoded)
    }

    init?(name: String, score: String) {
        self.name = name
        self.score = score
    } //init?
}

