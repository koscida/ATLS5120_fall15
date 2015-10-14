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
        var frameWidth = frame.size.width
        var halfFrameWidth = frameWidth / 2
        var frameHeight = frame.size.height
        var halfFrameHeight = frameHeight / 2
        
        
        mult = startMult
        addText("Welcome to Ripple",    color: SKNodeHelper.blue())
        
        mult -= gap
        addText("Select the good.",     color: DataManager.getGoodColor())
        mult -= line
        addText("Avoid the bad.",       color: DataManager.getBadColor())
        
        mult -= gap
        addText("Do it quick,",         color: SKNodeHelper.blue())
        mult -= line
        addText("before the",           color: SKColor(red: 0, green: 0.6, blue: 1.0, alpha: 0.7))
        mult -= line
        addText("ripples",              color: SKColor(red: 0, green: 0.6, blue: 1.0, alpha: 0.5))
        mult -= line
        addText("disappear!",           color: SKColor(red: 0, green: 0.6, blue: 1.0, alpha: 0.3))
        
        
        // go background
        mult = mult - gap - line
        addChild(SKNodeHelper.createSquare(CGRect(x: halfFrameWidth-100, y: frameHeight*mult, width: 200, height: 60), color: SKNodeHelper.blue(), corners: 20))
        
        // go text
        mult += (line - (line/2) - 0.005)
        addText("GO!",                  color: SKColor.whiteColor())
        
    }
    
    func addText(text: String, color: SKColor) {
        addChild(SKNodeHelper.createLabel(text, x: frame.size.width/2, y: frame.size.height * mult, fontSize: 35, color: color))
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
