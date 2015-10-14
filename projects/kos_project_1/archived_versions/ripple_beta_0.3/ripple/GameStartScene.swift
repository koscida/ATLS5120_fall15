//
//  GameStartScene.swift
//  ripple
//
//  Created by Brittany Kos on 9/28/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import UIKit
import SpriteKit

class GameStartScene: SKScene {
    
    var badFrame = SKNode()
    var goodFrame = SKNode()
    
    var goodSelectBox = SKShapeNode()
    var badSelectBox = SKShapeNode()
    
    var goodNode = SKShapeNode()
    var badNode = SKShapeNode()
    
    var goodSelected = false
    var badSelected = false
    
    var goodColor = SKColor(white: 0, alpha: 1)
    var badColor = SKColor(white: 0, alpha: 1)
    //var goodColor = SKColor(red: CGFloat(250/255.0), green: CGFloat(132/255.0), blue: CGFloat(14/255.0), alpha: 1.0)
    //var badColor = SKColor(red: CGFloat(100/255.0), green: CGFloat(100/255.0), blue: CGFloat(100/255.0), alpha: 1.0)
    
    var colors = [SKShapeNode]()
    
    
    
    override init(size: CGSize) {
        super.init(size: size)
        
        // set background color
        var frameWidth = CGRectGetWidth(frame)
        var frameHeight = CGRectGetHeight(frame)
        backgroundColor = SKColor.whiteColor()
        
        goodColor = DataManager.getGoodColor()
        badColor = DataManager.getBadColor()
        
        
        //////////////////////
        //      Title       //
        //////////////////////
        let select = SKLabelNode(fontNamed: "helvetica")
        select.text = "Select your colors!"
        select.fontColor = SKColor(red: 0, green: 0.6, blue: 1.0, alpha: 1)
        select.fontSize = 20
        select.verticalAlignmentMode = .Top
        select.horizontalAlignmentMode = .Left
        select.position = CGPointMake(8, frame.size.height-16)
        addChild(select)
        
        
        //////////////////////////
        //      Good Color      //
        //////////////////////////
        goodFrame.name = "goodFrame"
        addChild(goodFrame)
        
        goodSelectBox = SKShapeNode(rect: CGRect(x: 0, y: frameHeight-16-55-30, width: frameWidth, height: 45))
        goodSelectBox.name = "goodFrame"
        goodSelectBox.fillColor = SKColor(white: 0.75, alpha: 1.0)
        goodSelectBox.zPosition = 10
        
        let goodLabel = SKLabelNode(fontNamed: "helvetica")
        goodLabel.name = "goodFrame"
        goodLabel.text = "Good:"
        goodLabel.fontColor = SKColor(red: 0, green: 0.6, blue: 1.0, alpha: 1)
        goodLabel.fontSize = 20
        goodLabel.verticalAlignmentMode = .Top
        goodLabel.horizontalAlignmentMode = .Left
        goodLabel.position = CGPointMake(8, frameHeight-16-55)
        goodLabel.zPosition = 11
        goodFrame.addChild(goodLabel)
        
        goodNode = SKShapeNode(rect: CGRect(x: frameWidth/2, y: frameHeight-16-55-20, width: (frameWidth/2)-8, height: 25))
        goodNode.name = "goodFrame"
        goodNode.fillColor = goodColor
        goodNode.zPosition = 11
        goodFrame.addChild(goodNode)
        
        
        //////////////////////////
        //      Bad Color       //
        //////////////////////////
        badFrame.name = "badFrame"
        addChild(badFrame)
        
        badSelectBox = SKShapeNode(rect: CGRect(x: 0, y: frameHeight-16-110-30, width: frameWidth, height: 45))
        badSelectBox.name = "badFrame"
        badSelectBox.fillColor = SKColor(white: 0.75, alpha: 1.0)
        badSelectBox.zPosition = 10
        
        let badLabel = SKLabelNode(fontNamed: "helvetica")
        badLabel.name = "badFrame"
        badLabel.text = "Bad:"
        badLabel.fontColor = SKColor(red: 0, green: 0.6, blue: 1.0, alpha: 1)
        badLabel.fontSize = 20
        badLabel.verticalAlignmentMode = .Top
        badLabel.horizontalAlignmentMode = .Left
        badLabel.position = CGPointMake(8, frameHeight-16-110)
        badLabel.zPosition = 11
        badFrame.addChild(badLabel)
        
        badNode = SKShapeNode(rect: CGRect(x: frameWidth/2, y: frameHeight-16-110-20, width: (frameWidth/2)-8, height: 25))
        badNode.name = "badFrame"
        badNode.fillColor = badColor
        badNode.zPosition = 11
        badFrame.addChild(badNode)

        
        /////////////////////////////
        //      Color Picker       //
        /////////////////////////////
        var blockSize: CGFloat = (frame.size.width - 16)/6

        // set the color selection
        var offSetX: CGFloat = 8
        var offSetY: CGFloat = 85
        var offSetHue: CGFloat = 0
        var offSetBri: CGFloat = 0.2
        
        
        for(var i: CGFloat=0; i<6; i++) {
            for(var j: CGFloat=0; j<6; j++) {
                
                var c = SKShapeNode(rect: CGRect(x: offSetX, y: offSetY, width: blockSize, height: blockSize))
                c.fillColor = SKColor(hue: offSetHue, saturation: 1.0, brightness: offSetBri, alpha: 1.0)
                c.lineWidth = 0
                c.name = "colorNode"
                
                colors.append(c)
                addChild(c)
                
                offSetX += blockSize
                offSetHue += (1/6)
            }
            offSetX = 8
            offSetY += blockSize
            offSetHue = 0
            offSetBri += 0.1
        }
        
        
        ////////////////////////////
        //      Play Button       //
        ////////////////////////////
        
        // play box
        let playBox = SKShapeNode(rect: CGRect(x: ((frameWidth/2)-100), y: 16, width: 200, height: 60), cornerRadius: 20.0)
        playBox.lineWidth = 0
        playBox.fillColor = UIColor(red: 0, green: 0.6, blue: 1.0, alpha: 1)
        playBox.name = "playBtn"
        addChild(playBox)
        
        // play text
        let playLabel = SKLabelNode(fontNamed: "helvetica")
        playLabel.text = "Go!"
        playLabel.fontColor = UIColor.whiteColor()
        playLabel.fontSize = 35
        playLabel.verticalAlignmentMode = .Top
        playLabel.position = CGPointMake(frameWidth/2, 35+16+10)
        addChild(playLabel)
    }
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            
            if(touchedNode.name == nil) {
                if (goodSelected) {
                    goodSelected = false
                    goodSelectBox.removeFromParent()
                } else if(badSelected) {
                    badSelected = false
                    badSelectBox.removeFromParent()
                }
            }
            
            // play the game
            else if(touchedNode.name == "playBtn") {
                DataManager.saveColors(goodColor, badColor: badColor)
                
                let transition = SKTransition.flipVerticalWithDuration(1.0)
                let game = GameInstructionsScene(size:frame.size)
                view!.presentScene(game, transition: transition)
            }
            
            // switch which one is selected
            else if(touchedNode.name == "goodFrame") {
                if(badSelected || (!badSelected && !goodSelected)) {
                    goodSelected = true
                    goodFrame.addChild(goodSelectBox)
                    
                    badSelected = false
                    badSelectBox.removeFromParent()
                }
            }
            
            else if(touchedNode.name == "badFrame") {
                if(goodSelected || (!badSelected && !goodSelected)) {
                    badSelected = true
                    badFrame.addChild(badSelectBox)
                    
                    goodSelected = false
                    goodSelectBox.removeFromParent()
                }
            }
            
            else if(touchedNode.name == "colorNode") {
                // touched on a color
                for(var i=0; i<colors.count; i++) {
                    if(touchedNode == colors[i]) {
                        
                        // get the color of block clicked on
                        var nodeRed: CGFloat = 0
                        var nodeGreen: CGFloat = 0
                        var nodeBlue: CGFloat = 0
                        var nodeAlpha: CGFloat = 0
                        colors[i].fillColor.getRed(&nodeRed, green: &nodeGreen, blue: &nodeBlue, alpha: &nodeAlpha)
                        
                        if(goodSelected) {
                            goodColor = SKColor(red: nodeRed, green: nodeGreen, blue: nodeBlue, alpha: nodeAlpha)
                            goodNode.fillColor = goodColor
                        }
                        if(badSelected) {
                            badColor = SKColor(red: nodeRed, green: nodeGreen, blue: nodeBlue, alpha: nodeAlpha)
                            badNode.fillColor = badColor
                        }
                    }
                   
                }
            }// end else
            
            
        }
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
}
