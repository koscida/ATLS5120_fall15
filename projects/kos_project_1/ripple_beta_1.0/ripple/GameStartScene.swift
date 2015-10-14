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
        var title = SKNodeHelper.createLabel("Select your colors!", x: 8, y: frameHeight-16, fontSize: 20, color: SKNodeHelper.blue())
        title.verticalAlignmentMode = .Top
        title.horizontalAlignmentMode = .Left
        addChild(title)
        
        
        
        //////////////////////////
        //      Good Color      //
        //////////////////////////
        goodFrame.name = "goodFrame"
        addChild(goodFrame)
        
        // grey highlight
        goodSelectBox = SKNodeHelper.createSquare(CGRect(x: 0, y: frameHeight-16-55-30, width: frameWidth, height: 45), color: SKColor(white: 0.75, alpha: 1.0), name: "goodFrame", zIndex: 10)
        
        // good label text
        let goodLabel = SKNodeHelper.createLabel("Good: ", x: 8, y: frameHeight-16-55, fontSize: 20, color: SKNodeHelper.blue(), name: "goodFrame", zIndex: 11)
        goodLabel.verticalAlignmentMode = .Top
        goodLabel.horizontalAlignmentMode = .Left
        goodFrame.addChild(goodLabel)
        
        // good color box
        goodNode = SKNodeHelper.createSquare(CGRect(x: frameWidth/2, y: frameHeight-16-55-20, width: (frameWidth/2)-8, height: 25), color: goodColor, corners: 0, name: "goodFrame", zIndex: 11)
        goodFrame.addChild(goodNode)
        
        
        
        //////////////////////////
        //      Bad Color       //
        //////////////////////////
        badFrame.name = "badFrame"
        addChild(badFrame)
        
        // grey highlight
        badSelectBox = SKNodeHelper.createSquare(CGRect(x: 0, y: frameHeight-16-110-30, width: frameWidth, height: 45), color: SKColor(white: 0.75, alpha: 1.0), name: "badFrame", zIndex: 10)
        
        // bad label text
        let badLabel = SKNodeHelper.createLabel("Bad: ", x: 8, y: frameHeight-16-110, fontSize: 20, color: SKNodeHelper.blue(), name: "badFrame", zIndex: 11)
        badLabel.verticalAlignmentMode = .Top
        badLabel.horizontalAlignmentMode = .Left
        badFrame.addChild(badLabel)
        
        // bad color box
        badNode = SKNodeHelper.createSquare(CGRect(x: frameWidth/2, y: frameHeight-16-110-20, width: (frameWidth/2)-8, height: 25), color: badColor, corners: 0, name: "badFrame", zIndex: 11)
        badFrame.addChild(badNode)
        
        
        
        /////////////////////////////
        //      Color Picker       //
        /////////////////////////////
        var blockSize: CGFloat = (frame.size.width - 16)/6
        if(blockSize > 50) {
            blockSize = 35
        }

        // set the color selection
        var origOffSetX = (frameWidth/2) - (3*blockSize)
        var offSetX: CGFloat = origOffSetX
        var offSetY: CGFloat = 85
        var offSetHue: CGFloat = 0
        var offSetBri: CGFloat = 0.3
        
        
        for(var i: CGFloat=0; i<6; i++) {
            for(var j: CGFloat=0; j<6; j++) {
                
                var c = SKNodeHelper.createSquare(CGRect(x: offSetX, y: offSetY, width: blockSize, height: blockSize), color: SKColor(hue: offSetHue, saturation: 1.0, brightness: offSetBri, alpha: 1.0), name: "colorNode")
                colors.append(c)
                addChild(c)
                
                offSetX += blockSize
                offSetHue += (1/6)
            }
            offSetX = origOffSetX
            offSetY += blockSize
            offSetHue = 0
            offSetBri += 0.1
        }
        
        
        ////////////////////////////
        //      Play Button       //
        ////////////////////////////
        
        // play box
        addChild(SKNodeHelper.createSquare(CGRect(x: ((frameWidth/2)-100), y: 16, width: 200, height: 60), color: SKNodeHelper.blue(), corners: 20, name: "playBtn"))
        
        // play text
        addChild(SKNodeHelper.createLabel("Go!", x: frameWidth/2, y: 16+17, fontSize: 35, name: "playBtn"))
    }
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            //println(touchedNode.name)
            
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
