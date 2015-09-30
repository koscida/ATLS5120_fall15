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
        backgroundColor = SKColor(red: 0, green: 0.6, blue: 1.0, alpha: 1)
        
        // "Game Over" text
        let gameOver = SKLabelNode(fontNamed: "Helvetica")
        gameOver.text = "Game Over"
        gameOver.fontColor = SKColor.whiteColor()
        gameOver.fontSize = 50
        gameOver.position = CGPointMake(frame.size.width/2, (frame.size.height/2)+175)
        addChild(gameOver)
        
        
        // Score text
        let scoreLabel = SKLabelNode(fontNamed: "helvetica")
        scoreLabel.fontColor = SKColor.whiteColor()
        scoreLabel.fontSize = 35
        scoreLabel.position = CGPointMake(frame.size.width/2, (frame.size.height/2)+50)
        scoreLabel.text = (newHighScore) ? "New High Score!!!" : "Score"
        addChild(scoreLabel)
        
        // Score value
        let scoreValue = SKLabelNode(fontNamed: "helvetica")
        scoreValue.fontColor = SKColor.whiteColor()
        scoreValue.fontSize = 50
        scoreValue.position = CGPointMake(frame.size.width/2, (frame.size.height/2)-20)
        scoreValue.text = String(score)
        addChild(scoreValue)

        
        
        // "Play Again" button
        let playAgain = SKLabelNode(fontNamed: "helvetica")
        playAgain.text = "Play Again"
        playAgain.fontColor = SKColor.whiteColor()
        playAgain.fontSize = 35
        playAgain.position = CGPointMake(frame.size.width/2, (frame.size.height/2)-140)
        addChild(playAgain)
        
        
        
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
