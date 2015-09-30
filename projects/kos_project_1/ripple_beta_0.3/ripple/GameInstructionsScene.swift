//
//  StartScene.swift
//  ripple
//
//  Created by Brittany Kos on 9/24/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import UIKit
import SpriteKit

class GameInstructionsScene: SKScene {
    
    var mult: CGFloat = 0.0
    var startMult: CGFloat = 0.85
    var gap: CGFloat = 0.125
    var line: CGFloat = 0.075
    
   
    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = SKColor.whiteColor()
        
        mult = startMult
        addText("Welcome to Ripple",    color: SKColor(red: 0, green: 0.6, blue: 1.0, alpha: 1))
        
        mult -= gap
        addText("Select the good.",     color: DataManager.getGoodColor())
        mult -= line
        addText("Avoid the bad.",       color: DataManager.getBadColor())
        
        mult -= gap
        addText("Do it quick,",         color: SKColor(red: 0, green: 0.6, blue: 1.0, alpha: 1))
        mult -= line
        addText("before the",           color: SKColor(red: 0, green: 0.6, blue: 1.0, alpha: 0.7))
        mult -= line
        addText("ripples",              color: SKColor(red: 0, green: 0.6, blue: 1.0, alpha: 0.5))
        mult -= line
        addText("disappear!",           color: SKColor(red: 0, green: 0.6, blue: 1.0, alpha: 0.3))
        
        
        mult = mult - gap - line
        let goBox = SKShapeNode(rect: CGRect(x: ((frame.size.width/2)-100), y: frame.size.height * mult, width: 200, height: 60), cornerRadius: 20.0)
        goBox.lineWidth = 0
        goBox.fillColor = UIColor(red: 0, green: 0.6, blue: 1.0, alpha: 1)
        addChild(goBox)
        
        mult += (line - (line/2))
        addText("GO!",                  color: SKColor.whiteColor())
        
    }
    
    func addText(text: String, color: SKColor) {
        
        let label = SKLabelNode(fontNamed: "helvetica")
        label.text = text
        label.fontColor = color
        label.fontSize = 35
        label.position = CGPointMake(frame.size.width/2, frame.size.height * mult)
        
        addChild(label)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let transition = SKTransition.flipVerticalWithDuration(1.0)
        let game = GameScene(size:frame.size)
        view!.presentScene(game, transition: transition)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
