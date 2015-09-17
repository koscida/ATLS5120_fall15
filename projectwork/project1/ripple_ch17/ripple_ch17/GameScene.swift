//
//  GameScene.swift
//  ripple_ch17
//
//  Created by Brittany Kos on 9/11/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    private var levelNumber: UInt
    private var playerLives: Int
    private var finished = false
    private let playerNode: PlayerNode = PlayerNode()
    
    var frame_width: CGFloat = 0;
    var frame_height: CGFloat = 0;
    
    private var circles = [CircleNode]()
    
    var time_frame = 1
    var time_sec = 0
    
    var toDelete = -1
    var respan_rate = 90
    
    
    class func scene(size: CGSize, levelNumber: UInt) -> GameScene {
        return GameScene(size: size, levelNumber: levelNumber)
    }
    
    override convenience init(size: CGSize) {
        self.init(size: size, levelNumber: 1)
    }
    
    init(size: CGSize, levelNumber: UInt) {
        self.levelNumber = levelNumber
        self.playerLives = 5
        super.init(size: size)
        
        frame_width = CGRectGetWidth(frame)
        frame_height = CGRectGetHeight(frame)
        
        
        backgroundColor = SKColor.whiteColor()
        
        playerNode.position = CGPointMake(CGRectGetMidX(frame), CGRectGetHeight(frame) * 0.1)
        addChild(playerNode)
        
        circles.append(CircleNode(f_w: frame_width, f_h: frame_height))
        
        for c in circles {
            addChild(c)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        levelNumber = UInt(aDecoder.decodeIntegerForKey("level"))
        playerLives = aDecoder.decodeIntegerForKey("playerLives")
        super.init(coder: aDecoder)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(Int(levelNumber), forKey: "level")
        aCoder.encodeInteger(playerLives, forKey: "playerLives")
    }
        
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        // loop through all circles
        var i=0
        for c in circles {
            
            // draw circles
            c.draw();
            
            // mark circle for deletion
            if(c.radius >= 50 && toDelete == -1) {
                toDelete = i
            }
            i++
        }
        
        // actually delete the circle
        if toDelete != -1 {
            circles[toDelete].removeFromParent()
            circles.removeAtIndex(toDelete)
            toDelete = -1
        }
        
        // add new circle
        if( (time_sec * 30 + time_frame) % respan_rate == 0) {
            var c = CircleNode(f_w: frame_width, f_h: frame_height)
            circles.append(c)
            addChild(c)
        }
        
        // update frame count
        if(time_frame < 30) {
            time_frame++
        } else {
            time_frame = 0
            time_sec++
        }
        
        // update respan rate
        if(time_frame == 0 && time_sec % 5 == 0 && respan_rate >= 20) {
            respan_rate -= 20
        }
        
        
        
    }
}
