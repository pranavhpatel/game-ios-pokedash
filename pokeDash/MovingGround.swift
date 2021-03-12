//
//  MovingGround.swift
//  pokeDash
//
//  Created by Prism Student on 2020-04-17.
//  Copyright © 2020 Pranav Patel. All rights reserved.
//

import Foundation
import SpriteKit

class MovingGround: SKSpriteNode{
    
    let NUMBER_OF_SEGMENTS = 20
    let color_seg1 = UIColor(red: 80/255, green: 150/255, blue: 90/255, alpha: 1.0)
    let color_seg2 = UIColor(red: 160/255, green: 190/255, blue: 100/255, alpha: 1.0)
    init (size: CGSize){
        super.init(texture: nil, color: UIColor.brown, size: CGSize(width: size.width*2, height: size.height))
        anchorPoint = CGPoint(x: 0, y: 0.5)
        
        for i in 1...NUMBER_OF_SEGMENTS{
            print(i)
            var segmentColor: UIColor!
            if i % 2 == 0 {
                segmentColor = color_seg1
            }
            else{
                segmentColor = color_seg2
            }
            let segment = SKSpriteNode(color: segmentColor, size: CGSize(width: size.width / CGFloat(NUMBER_OF_SEGMENTS), height: self.size.height))
            segment.anchorPoint = CGPoint(x: 0, y: 0.5)
            segment.position = CGPoint(x: CGFloat(i) + segment.size.width, y: 0)
            addChild(segment)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start(){
        let moveLeft = SKAction.moveBy(x: -frame.size.width/2, y: 0, duration: 1.0)
        let resetPosition = SKAction.moveTo(x: 0, duration: 0)
        
        let moveSequence = SKAction.sequence([moveLeft, resetPosition])
        run(SKAction.repeatForever(moveSequence))
    }
}
