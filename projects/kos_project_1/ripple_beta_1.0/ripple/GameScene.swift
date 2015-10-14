//
//  GameScene.swift
//  ripple
//
//  Created by Brittany Ann Kos on 9/24/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import SpriteKit
import CoreGraphics

class GameScene: SKScene {
    
    var currentPoints: UInt = 0
    var oldPoints: UInt = 0
    var lives: Int
    var finished = false
    
    var frameWidth: CGFloat = 0;
    var frameHeight: CGFloat = 0;
    
    var pointsLabel = SKLabelNode(fontNamed: "helvetica")
    var highLabel = SKLabelNode(fontNamed: "helvetica")
    var highPoints = 0
    var livesImages = [SKSpriteNode]()
    
    var gamePause = false
    var playFrame = SKNode()
    var pauseFrame = SKNode()
    
    var circles = [CircleNode]()
    var cirTotal = 0
    var cirTouched = 0
    var toDeleteCircle = -1
    var newCircle = CircleNode()
    
    var touchResults = [RippleTouchResultNode]()
    var toDeleteTR = -1
    
    var startTime = CACurrentMediaTime()
    var now = CACurrentMediaTime()
    var elapsed = CACurrentMediaTime()
    var oldTime: CFTimeInterval = CFTimeInterval()
    
    var respanRate: CGFloat = 0.5
    var radiusRate: CGFloat = 0.7
    var maxRadius: CGFloat = 60
    
    var goodColor = SKColor(white: 0, alpha: 1)
    var badColor = SKColor(white: 0, alpha: 1)
    
    
    
    class func scene(size: CGSize, points: UInt) -> GameScene {
        return GameScene(size: size, points: points)
    }
    
    override convenience init(size: CGSize) {
        self.init(size: size, points: 1)
    }
    
    init(size: CGSize, points: UInt) {
        self.currentPoints = 0
        self.oldPoints = 0
        self.lives = 3
        super.init(size: size)
        
        // set size and background color
        frameWidth = CGRectGetWidth(frame)
        frameHeight = CGRectGetHeight(frame)
        backgroundColor = SKColor.whiteColor()
        
        goodColor = DataManager.getGoodColor()
        badColor = DataManager.getBadColor()
        
        
        ///////////////////////////
        //      Header Bar       //
        ///////////////////////////
        var barH: CGFloat = 44
        addChild(SKNodeHelper.createSquare(CGRect(x: 0, y: frameHeight-barH, width: frameWidth, height: barH), color: SKNodeHelper.blue(), name: "", zIndex: 10))
        
        
        // lives hearts
        for (var i=0; i<self.lives; i++) {
            var life = SKSpriteNode(imageNamed: "heart.png")
            life.position = CGPoint(x: CGFloat(8 + (i*34)), y: frameHeight - barH + 8)
            life.anchorPoint = CGPoint(x:0.0,y:0.0)
            life.size = CGSize(width: 28, height: 28)
            life.zPosition = 11
            livesImages.append(life)
            addChild(life)
        }
        
        
        // current points label
        pointsLabel = SKNodeHelper.createLabel("\(points)", x: (frameWidth/2) - 4+20, y: frameHeight-8, fontSize: 32, zIndex: 11)
        pointsLabel.verticalAlignmentMode = .Top
        pointsLabel.horizontalAlignmentMode = .Right
        addChild(pointsLabel)
        
        
        // highest points label
        var hp = DataManager.getHighPoints()
        highPoints = hp.toInt()!
        highLabel = SKNodeHelper.createLabel(hp, x: (frameWidth/2) + 4+20, y: frameHeight-14, fontSize: 24, zIndex: 11)
        highLabel.verticalAlignmentMode = .Top
        highLabel.horizontalAlignmentMode = .Left
        addChild(highLabel)
        
        
        
        /////////////////////////////////////////////////////////////
        //      Play Frame - will hold all the play elements       //
        /////////////////////////////////////////////////////////////
        playFrame = SKNode()
        playFrame.zPosition = 20
        addChild(playFrame)
        
        // pause button
        var pauseBtn = SKSpriteNode(imageNamed: "pause.png")
        pauseBtn.name = "pauseBtn"
        pauseBtn.position = CGPoint(x: frameWidth - 28 - 8, y: frameHeight - barH + 8)
        pauseBtn.anchorPoint = CGPoint(x:0.0,y:0.0)
        pauseBtn.size = CGSize(width: 28, height: 28)
        playFrame.addChild(pauseBtn)
        
        
        ///////////////////////////////////////////////////////////////
        //      Pause Frame - will hold all the pause elements       //
        ///////////////////////////////////////////////////////////////
        pauseFrame = SKNode()
        pauseFrame.zPosition = 20
        
        // play button
        var playBtn = SKSpriteNode(imageNamed: "play.png")
        playBtn.name = "playBtn"
        playBtn.position = CGPoint(x: frameWidth - 28 - 8, y: frameHeight - barH + 8)
        playBtn.anchorPoint = CGPoint(x:0.0,y:0.0)
        playBtn.size = CGSize(width: 28, height: 28)
        playBtn.zPosition = 11
        pauseFrame.addChild(playBtn)
        
        
        // pause overlay
        pauseFrame.addChild(SKNodeHelper.createSquare(CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight - barH), color: SKColor(white: 0.4, alpha: 0.5)))
        
        
        // pause text background
        var pauseBackH: CGFloat = 130
        pauseFrame.addChild(SKNodeHelper.createSquare(CGRect(x: 0, y: frameHeight-barH-pauseBackH, width: frameWidth, height: pauseBackH), color: SKColor(white: 0.5, alpha: 0.8)))
        
        // pause text
        pauseFrame.addChild(SKNodeHelper.createLabel("Paused", x: frameWidth/2, y: frameHeight-barH-(pauseBackH/2)-16, fontSize: 32))
        
        
        // reset text background
        pauseFrame.addChild(SKNodeHelper.createSquare(CGRect(x: (frameWidth/2)-140, y: (frameHeight-barH) * (0.4), width: 280, height: 50), color: SKNodeHelper.blue(), corners: 15, name: "restartBtn"))
        
        // reset text
        pauseFrame.addChild(SKNodeHelper.createLabel("Reset Game", x: frameWidth/2, y: (frameHeight-barH) * (0.4) + 14, fontSize: 32, name: "restartBtn"))
        
        
        // new colors text background
        pauseFrame.addChild(SKNodeHelper.createSquare(CGRect(x: (frameWidth/2)-140, y: (frameHeight-barH) * (0.25), width: 280, height: 50), color: SKNodeHelper.blue(), corners: 15, name: "newColorsBtn"))
        
        // new colors text
        pauseFrame.addChild(SKNodeHelper.createLabel("Select new colors", x: frameWidth/2, y: (frameHeight-barH) * (0.25) + 14, fontSize: 32, name: "newColorsBtn"))
        
        
        // warning text background
        pauseFrame.addChild(SKNodeHelper.createSquare(CGRect(x: 0, y: 0, width: frameWidth, height: 85), color: SKColor(white: 0.5, alpha: 0.8)))
        
        // warning text
        pauseFrame.addChild(SKNodeHelper.createLabel("Warning: Selecting any of the above", x: frameWidth/2, y: 56, fontSize: 16))
        pauseFrame.addChild(SKNodeHelper.createLabel("options will stop the game, deleting", x: frameWidth/2, y: 36, fontSize: 16))
        pauseFrame.addChild(SKNodeHelper.createLabel("any points you have accumulated.", x: frameWidth/2, y: 16, fontSize: 16))
        

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        currentPoints = UInt(aDecoder.decodeIntegerForKey("pts"))
        lives = aDecoder.decodeIntegerForKey("lives")
        super.init(coder: aDecoder)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(Int(currentPoints), forKey: "pts")
        aCoder.encodeInteger(lives, forKey: "lives")
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            
            // touch location
            let location = touch.locationInNode(self)
            // which node touched
            let touchedNode = self.nodeAtPoint(location)
            
            if(touchedNode.name == "pauseBtn") {
                gamePause = true
                playFrame.removeFromParent()
                addChild(pauseFrame)
                
            } else if(touchedNode.name == "playBtn") {
                gamePause = false
                pauseFrame.removeFromParent()
                addChild(playFrame)
                
            } else if(touchedNode.name == "restartBtn") {
                triggerRestart()
                
            } else if(touchedNode.name == "newColorsBtn") {
                triggerNewColors()
            
            } else {
                // loop through all the circles
                for(var i=0; i<circles.count; i++) {
                    
                    // if touched this circle
                    if circles[i].circle == touchedNode {
                        
                        // if a good circle
                        if(circles[i].goodCircle) {
                            // add to the number of circles touched
                            cirTouched++
                            
                            // calc points added
                            var rad = circles[i].radius
                            var pts = UInt((rad - 60) * (0-1))
                            
                            // add to total points
                            currentPoints += pts
                            
                            // add the gained points notification
                            var tr = RippleTouchResultNode(x: location.x, y: location.y, text: "+\(pts)")
                            touchResults.append(tr)
                            addChild(tr)
                            
                            // update respan rate
                            if(respanRate > CGFloat(0.2)) {
                                respanRate -= 0.0005
                            } else {
                                respanRate = 0.3
                            }
                            //println(respanRate)
                            
                            // update ripple speed
                            if(radiusRate < CGFloat(1.0)) {
                                radiusRate += 0.02
                            }
                            
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
                                
                                // subtract from lives, lives array, and superview
                                lives--
                                livesImages[lives].removeFromParent()
                                livesImages.removeAtIndex(lives)
                            }
                        }
                    
                    
                        // remove the circle that was clicked on
                        circles[i].removeFromParent()
                        circles.removeAtIndex(i)
                        
                        break
                    } // end for loop for looping through all circles
                    
                } // end else
            }
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if(!gamePause) {
        
            //////////////////////////////
            //      update now time     //
            //////////////////////////////
            now = CACurrentMediaTime();
            elapsed = now - startTime;
            
            
            //////////////////////////////////////////
            //      loop through all circles        //
            //////////////////////////////////////////
            for(var i=0; i<circles.count; i++) {
                
                // draw circles
                circles[i].update(radiusRate)
                circles[i].draw()
                
                // mark circle for deletion
                if(circles[i].radius >= maxRadius && toDeleteCircle == -1) {
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
            if( (oldTime % Double(respanRate)) > (currentTime % Double(respanRate)) ) {
                if( (random() % 5) == 1) {
                    newCircle = CircleNode(frameWidth: frameWidth, frameHeight: frameHeight-44, good: false, color: badColor, maxRadius: maxRadius)
                } else {
                    newCircle = CircleNode(frameWidth: frameWidth, frameHeight: frameHeight-44, good: true, color: goodColor, maxRadius: maxRadius)
                }
                cirTotal++
                circles.append(newCircle)
                addChild(newCircle)
            }
            
            
            //////////////////////////////////////////////////////
            //      loop through all gained points nodes        //
            //////////////////////////////////////////////////////
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
            
            
            
            //////////////////////////////
            //      Update points       //
            //////////////////////////////
            if( currentPoints != oldPoints ) {
                if(oldPoints + 2 <= currentPoints) {
                    oldPoints += 2;
                } else {
                    oldPoints += (currentPoints - oldPoints);
                }
                pointsLabel.text = "\(oldPoints)"
            }
            
            
            //////////////////////////////
            //      update old time     //
            //////////////////////////////
            oldTime = currentTime
            
        // end if(!gamePause)
        // if game is paused
        } else {
            
        }
        
    }
    
    
    private func triggerNewColors() {
        let transition = SKTransition.flipVerticalWithDuration(1.0)
        let scene = GameStartScene(size: frame.size)
        view!.presentScene(scene, transition: transition)
    }
    
    private func triggerRestart() {
        let transition = SKTransition.flipVerticalWithDuration(1.0)
        let scene = GameScene(size: frame.size)
        view!.presentScene(scene, transition: transition)
    }
    
    private func triggerGameOver() {
        finished = true
        
        var newHighScore = false
        
        if highPoints < Int(currentPoints) {
            DataManager.saveHighPoints(String(currentPoints))
            newHighScore = true
        }
        
        let transition = SKTransition.flipVerticalWithDuration(1.0)
        let scene = GameOverScene(size: frame.size, newHighScore: newHighScore, score: Int(currentPoints))
        view!.presentScene(scene, transition: transition)
    }
}
