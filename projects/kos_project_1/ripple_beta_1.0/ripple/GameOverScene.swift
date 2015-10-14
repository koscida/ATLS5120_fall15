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
   
    init(size: CGSize, newHighScore: Bool, score: Int) {
        super.init(size: size)
        
        // set blue background
        backgroundColor = SKColor.whiteColor()
        var frameWidth = frame.size.width
        var halfFrameWidth = frameWidth / 2
        var frameHeight = frame.size.height
        var halfFrameHeight = frameHeight / 2

        
        // top blue box
        addChild(SKNodeHelper.createSquare(CGRect(x: 0, y: frameHeight * (3/4), width: frameWidth, height: frameHeight/4), color: UIColor(red: 0, green: 0.6, blue: 1.0, alpha: 1)))

        // "Game Over" text
        addChild(SKNodeHelper.createLabel("Game Over", x: halfFrameWidth, y: frameHeight * (7/8) - 25, fontSize: 50))
        
        
        
        // Score text
        var text = (newHighScore) ? "New High Score!!!" : "Score: "
        addChild(SKNodeHelper.createLabel(text, x: halfFrameWidth, y: halfFrameHeight+50, fontSize: 35, color: SKColor.blackColor()))
        
        // Score value
        addChild(SKNodeHelper.createLabel(String(score), x: halfFrameWidth, y: halfFrameHeight-20, fontSize: 50, color: SKColor.blackColor()))

        
        
        // play again background
        addChild(SKNodeHelper.createSquare(CGRect(x: halfFrameWidth-125, y: halfFrameHeight-128, width: 250, height: 60), color: SKNodeHelper.blue(), corners: 20, name: "playAgain"))
        
        // "Play Again" button
        addChild(SKNodeHelper.createLabel("Play Again", x: halfFrameWidth, y: halfFrameHeight-110, fontSize: 35, name: "playAgain"))
        
        
        
        // change color background
        addChild(SKNodeHelper.createSquare(CGRect(x: halfFrameWidth-105, y: halfFrameHeight-228, width: 210, height: 50), color: SKNodeHelper.blue(), corners: 15, name: "changeColor"))
        
        // "Change Color" button
        addChild(SKNodeHelper.createLabel("Change Colors", x: halfFrameWidth, y: halfFrameHeight-210, fontSize: 20, name: "changeColor"))

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            
            if(touchedNode.name == "changeColor") {
                var game = GameStartScene(size: view!.frame.size)
                let transition = SKTransition.flipVerticalWithDuration(1.0)
                view!.presentScene(game, transition: transition)
                
            } else if(touchedNode.name == "playAgain") {
                var game = GameScene(size: frame.size)
                let transition = SKTransition.flipVerticalWithDuration(1.0)
                view!.presentScene(game, transition: transition)
            }
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
