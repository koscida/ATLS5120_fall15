//
//  CircleNode.swift
//  ripple_ch17
//
//  Created by Brittany Kos on 9/15/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class CircleNode: SKNode {
    
    var maxX: CGFloat = 0;
    var maxY: CGFloat = 0;
    
    var cirPath: CGMutablePathRef = CGPathCreateMutable()
    var radius: CGFloat = 0.0;
    var circle = SKShapeNode()
    
    var cirRed: CGFloat = 0.0
    var cirGreen: CGFloat = 0.0
    var cirBlue: CGFloat = 0.0
    var cirAlpha: CGFloat = 1.0
    
    var goodCircle = true
    
    init(frameWidth: CGFloat, frameHeight: CGFloat, good: Bool, color: SKColor) {
        super.init()
        
        maxX = frameWidth
        maxY = frameHeight
        
        goodCircle = good
        color.getRed(&cirRed, green: &cirGreen, blue: &cirBlue, alpha: &cirAlpha)
        
        self.position = CGPoint(
            x: Int(arc4random_uniform(UInt32(maxX-30)) + 15),
            y: Int(arc4random_uniform(UInt32(maxY-30)) + 15)
        )
        
        CGPathAddArc(cirPath, nil, 0.0, 0.0, radius, 0.0, (2.0 * CGFloat(M_PI)), true)
        circle.path = cirPath
        circle.fillColor = color
        self.addChild(circle)
        
    }
    

    func updateAndDraw() {
        radius += 0.7
        
        cirPath = CGPathCreateMutable()
        CGPathAddArc(cirPath, nil, 0.0, 0.0, radius, 0.0, (2.0 * CGFloat(M_PI)), true)
        circle.path = cirPath
        
        cirAlpha -= 0.01
        circle.fillColor = SKColor(red: cirRed, green: cirGreen, blue: cirBlue, alpha: cirAlpha)
    }
    
    
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
