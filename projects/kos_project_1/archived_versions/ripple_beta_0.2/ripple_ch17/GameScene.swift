//
//  GameScene.swift
//  ripple_ch17
//
//  Created by Brittany Kos on 9/11/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import SpriteKit
import CoreGraphics

class GameScene: SKScene {
    
    private var points: UInt
    private var lives: Int
    private var finished = false
    
    var frameWidth: CGFloat = 0;
    var frameHeight: CGFloat = 0;
    
    var pointsLabel = SKLabelNode(fontNamed: "helvetica")
    var livesLabel = SKLabelNode(fontNamed: "helvetica")
    
    private var circles = [CircleNode]()
    var cirTotal = 0
    var cirTouched = 0
    var toDeleteCircle = -1
    var newCircle = CircleNode()
    
    private var touchResults = [RippleTouchResultNode]()
    var toDeleteTR = -1
    
    var startTime = CACurrentMediaTime()
    var now = CACurrentMediaTime()
    var elapsed = CACurrentMediaTime()
    var oldTime: CFTimeInterval = CFTimeInterval()
    
    var respan_rate = 0.5 //1.5
    
    var goodColor = SKColor(red: CGFloat(250/255.0), green: CGFloat(132/255.0), blue: CGFloat(14/255.0), alpha: 1.0)
    var badColor = SKColor(red: CGFloat(100/255.0), green: CGFloat(100/255.0), blue: CGFloat(100/255.0), alpha: 1.0)

    
    
    class func scene(size: CGSize, points: UInt) -> GameScene {
        return GameScene(size: size, points: points)
    }
    
    override convenience init(size: CGSize) {
        self.init(size: size, points: 1)
    }
    
    init(size: CGSize, points: UInt) {
        self.points = points
        self.lives = 3
        super.init(size: size)
        
        // set size and background color
        frameWidth = CGRectGetWidth(frame)
        frameHeight = CGRectGetHeight(frame)
        backgroundColor = SKColor.whiteColor()
        
        
        // add the lives label at the top
        livesLabel.fontSize = 16
        livesLabel.fontColor = SKColor.blackColor()
        livesLabel.text = "Lives: \(lives)"
        livesLabel.verticalAlignmentMode = .Top
        livesLabel.horizontalAlignmentMode = .Left
        livesLabel.position = CGPointMake(8, frame.size.height-8)
        addChild(livesLabel)
        
        
        // add the points label at the top
        pointsLabel.fontSize = 16
        pointsLabel.fontColor = SKColor.blackColor()
        pointsLabel.text = "Points: \(points)"
        pointsLabel.name = "points_label"
        pointsLabel.verticalAlignmentMode = .Top
        pointsLabel.horizontalAlignmentMode = .Right
        pointsLabel.position = CGPointMake(frame.size.width-8, frame.size.height-8)
        addChild(pointsLabel)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        points = UInt(aDecoder.decodeIntegerForKey("pts"))
        lives = aDecoder.decodeIntegerForKey("lives")
        super.init(coder: aDecoder)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(Int(points), forKey: "pts")
        aCoder.encodeInteger(lives, forKey: "lives")
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            
            // touch location
            let location = touch.locationInNode(self)
            // which node touched
            let touchedNode = self.nodeAtPoint(location)
            
            // loop through all the circles
            for(var i=0; i<circles.count; i++) {
                
                // if touched this circle
                if circles[i].circle == touchedNode {
                    
                    // if a good circle
                    if(circles[i].goodCircle) {
                        // add to the number of circles touched
                        cirTouched++
                        
                        // calc points added
                        var p = UInt(circles[i].radius)
                        // add to total points and redraw
                        points += p
                        pointsLabel.text = "Points: \(points)"
                        
                        // add the gained points notification
                        var tr = RippleTouchResultNode(x: location.x, y: location.y, text: "+\(p)")
                        touchResults.append(tr)
                        addChild(tr)
                        
                        // update respan rate
                        
                        // update ripple speed
                        
                    // if a bad circle
                    } else {
                        
                        // check if game should end now
                        if(lives == 1) {
                            triggerGameOver()
                            
                        } else {
                            // add the gained points notification
                            var tr = RippleTouchResultNode(x: location.x, y: location.y, text: "-1 life")
                            touchResults.append(tr)
                            addChild(tr)
                            
                            // subtract from lives and redraw
                            lives--
                            livesLabel.text = "Lives: \(lives)"
                        }
                    }
                    
                    
                    // remove the circle that was clicked on
                    circles[i].removeFromParent()
                    circles.removeAtIndex(i)
                    
                    break
                }
            }
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        // update now time
        now = CACurrentMediaTime();
        elapsed = now - startTime;
        
        
        
        // loop through all circles
        for(var i=0; i<circles.count; i++) {
            
            // draw circles
            circles[i].updateAndDraw();
            
            // mark circle for deletion
            if(circles[i].radius >= 60 && toDeleteCircle == -1) {
                toDeleteCircle = i
            }
        }
        
        // actually delete the circle
        if toDeleteCircle != -1 {
            circles[toDeleteCircle].removeFromParent()  // remove from frame
            circles.removeAtIndex(toDeleteCircle)       // remove from list
            toDeleteCircle = -1                         // reset delete
        }
        
        // add new circle
        if( (oldTime % respan_rate) > (currentTime % respan_rate) ) {
            if( (random() % 2) == 1) {
                newCircle = CircleNode(frameWidth: frameWidth, frameHeight: frameHeight, good: true, color: goodColor)
            } else {
                newCircle = CircleNode(frameWidth: frameWidth, frameHeight: frameHeight, good: false, color: badColor)
            }
            cirTotal++
            circles.append(newCircle)
            addChild(newCircle)
        }
        
        
        
        // loop through all gained points nodes
        for(var i=0; i<touchResults.count; i++) {
            
            // draw circles
            touchResults[i].updateAndDraw();
            
            // mark circle for deletion
            if(touchResults[i].text_alpha <= 0 && toDeleteTR == -1) {
                toDeleteTR = i
            }
        }
        
        // actually delete the circle
        if toDeleteTR != -1 {
            touchResults[toDeleteTR].removeFromParent()
            touchResults.removeAtIndex(toDeleteTR)
            toDeleteTR = -1
        }

        
        
        // update old time
        oldTime = currentTime
        
    }
    
    
    private func triggerGameOver() {
        finished = true
        
        let transition = SKTransition.doorsOpenVerticalWithDuration(1)
        let gameOver = GameOverScene(size: frame.size)
        view!.presentScene(gameOver, transition: transition)
    }
}
