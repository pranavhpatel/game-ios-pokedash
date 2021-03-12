//
//  MusicInstance.swift
//  pokeDash
//
//  Created by Prism Student on 2020-04-19.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import Foundation
import UIKit
class MusicInstance {
    static var musicStatus:Bool = true
    
    //getter functions
    func getStatus() -> Bool{
        return MusicInstance.musicStatus
    }
    
    //setter functions
    func setStatus(to status: Bool){
        MusicInstance.musicStatus = status
    }

 // Mark: - Helpers
}

