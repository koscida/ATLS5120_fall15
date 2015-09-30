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
    var pauseBtn = SKSpriteNode(imageNamed: "pause.png")
    var pauseFrame = SKNode()
    var playBtn = SKSpriteNode(imageNamed: "play.png")
    var pauseOverlay = SKShapeNode()
    var pauseText = SKLabelNode(fontNamed: "helvetica")
    var pauseTextBack = SKShapeNode()
    
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
    //var goodColor = SKColor(red: CGFloat(250/255.0), green: CGFloat(132/255.0), blue: CGFloat(14/255.0), alpha: 1.0)
    //var badColor = SKColor(red: CGFloat(100/255.0), green: CGFloat(100/255.0), blue: CGFloat(100/255.0), alpha: 1.0)
    
    
    
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
        
        
        // top blue bar
        var topBar = SKShapeNode(rect: CGRect(x: 0, y: frameHeight-44, width: frameWidth, height: 44))
        topBar.fillColor = UIColor(red: 0, green: 0.6, blue: 1.0, alpha: 1)
        topBar.zPosition = 10
        addChild(topBar)
        
        
        // lives hearts
        for (var i=0; i<self.lives; i++) {
            var life = SKSpriteNode(imageNamed: "heart.png")
            life.position = CGPoint(x: CGFloat(8 + (i*34)), y: frameHeight - 44 + 8)
            life.anchorPoint = CGPoint(x:0.0,y:0.0)
            life.size = CGSize(width: 28, height: 28)
            life.zPosition = 11
            livesImages.append(life)
            addChild(life)
        }
        
        
        // current points label
        pointsLabel.fontSize = 32
        pointsLabel.fontColor = SKColor.whiteColor()
        pointsLabel.text = "\(points)"
        pointsLabel.name = "pointsLabel"
        pointsLabel.verticalAlignmentMode = .Top
        pointsLabel.horizontalAlignmentMode = .Right
        pointsLabel.position = CGPointMake((frameWidth/2) - 4+20, frameHeight-8)
        pointsLabel.zPosition = 11
        addChild(pointsLabel)
        
        
        // highest points label
        highPoints = DataManager.getHighPoints().toInt()!
        highLabel.fontSize = 24
        highLabel.fontColor = SKColor.whiteColor()
        highLabel.text = DataManager.getHighPoints()
        highLabel.name = "highLabel"
        highLabel.verticalAlignmentMode = .Top
        highLabel.horizontalAlignmentMode = .Left
        highLabel.position = CGPointMake((frameWidth/2) + 4+20, frameHeight-14)
        highLabel.zPosition = 11
        addChild(highLabel)
        
        
        
        // play frame - will hold all the play elements
        playFrame = SKNode()
        playFrame.zPosition = 20
        addChild(playFrame)
        
        // pause button
        pauseBtn.name = "pauseBtn"
        pauseBtn.position = CGPoint(x: frameWidth - 28 - 8, y: frameHeight - 44 + 8)
        pauseBtn.anchorPoint = CGPoint(x:0.0,y:0.0)
        pauseBtn.size = CGSize(width: 28, height: 28)
        playFrame.addChild(pauseBtn)
        
        
        // pause frame - will hold all the pause elements
        pauseFrame = SKNode()
        pauseFrame.zPosition = 20
        
        // play button
        playBtn.name = "playBtn"
        playBtn.position = CGPoint(x: frameWidth - 28 - 8, y: frameHeight - 44 + 8)
        playBtn.anchorPoint = CGPoint(x:0.0,y:0.0)
        playBtn.size = CGSize(width: 28, height: 28)
        playBtn.zPosition = 11
        pauseFrame.addChild(playBtn)

        // pause overlay
        pauseOverlay = SKShapeNode(rect: CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight - 44))
        pauseOverlay.fillColor = SKColor(white: 0.4, alpha: 0.5)
        pauseFrame.addChild(pauseOverlay)
        
        // pause text background
        pauseTextBack = SKShapeNode(rect: CGRect(x: (frameWidth/2) - 100, y: ((frameHeight - 44)/2), width: 200, height: 75), cornerRadius: 15)
        //pauseTextBack.fillColor = SKColor(red: 0, green: 0.6, blue: 1.0, alpha: 0.6)
        pauseTextBack.fillColor = SKColor(white: 0.8, alpha: 0.7)
        pauseTextBack.lineWidth = 0
        pauseFrame.addChild(pauseTextBack)
        
        // pause text
        pauseText.text = "Paused"
        pauseText.fontSize = 32
        pauseText.position = CGPointMake((frameWidth/2), (frameHeight/2))
        pauseFrame.addChild(pauseText)
        
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
                            println(respanRate)
                            
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
    
    
    private func triggerGameOver() {
        finished = true
        
        var newHighScore = false
        
        if highPoints < Int(currentPoints) {
            DataManager.saveHighPoints(String(currentPoints))
            newHighScore = true
        }
        
        let transition = SKTransition.flipVerticalWithDuration(1.0)
        let gameOver = GameOverScene(size: frame.size, newHighScore: newHighScore, score: Int(currentPoints))
        view!.presentScene(gameOver, transition: transition)
    }
}
