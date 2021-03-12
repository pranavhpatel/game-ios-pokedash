//
//  PhysicsCategory.swift
//  pokeDash
//
//  Created by Prism Student on 2020-04-17.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import Foundation
struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Pokemon     : UInt32 = 0b1       // 1
    static let Obj      : UInt32 = 0b10      // 2
    static let Ground   : UInt32 = 0b11     // 3
}
