//
//  GameOverScene.swift
//  ripple_ch17
//
//  Created by Brittany Kos on 9/23/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
   
    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = SKColor(red: 0, green: 0.6, blue: 1.0, alpha: 1)
        
        let text = SKLabelNode(fontNamed: "Helvetica")
        text.text = "Game Over"
        text.fontColor = SKColor.whiteColor()
        text.fontSize = 50
        text.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        addChild(text)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
