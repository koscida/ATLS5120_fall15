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
    
    var x = 0
    var y = 0
    
    var frame_width: CGFloat = 0;
    var frame_height: CGFloat = 0;
    
    var cir_path: CGMutablePathRef = CGPathCreateMutable()
    var radius: CGFloat = 0.0;
    var circle = SKShapeNode()
    
    var cir_r: CGFloat = 250/255
    var cir_g: CGFloat = 132/255
    var cir_b: CGFloat = 14/255
    var cir_alpha: CGFloat = 1.0

    
    
    init(f_w: CGFloat, f_h: CGFloat) {
        super.init()
        name = "Player \(self)"
        
        frame_width = f_w
        frame_height = f_h
        
        x = Int(arc4random_uniform(UInt32(frame_width)))
        y = Int(arc4random_uniform(UInt32(frame_height)))
        
        self.position = CGPoint(x: x, y: y)
        
        CGPathAddArc(cir_path, nil, 0.0, 0.0, radius, 0.0, (2.0 * CGFloat(M_PI)), true)
        circle.path = cir_path
        circle.fillColor = SKColor(red: cir_r, green: cir_g, blue: cir_b, alpha: cir_alpha)
        self.addChild(circle)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func draw() {
        radius += 1
        
        cir_path = CGPathCreateMutable()
        CGPathAddArc(cir_path, nil, 0.0, 0.0, radius, 0.0, (2.0 * CGFloat(M_PI)), true)
        circle.path = cir_path
        
        cir_alpha -= 0.02
        circle.fillColor = SKColor(red: cir_r, green: cir_g, blue: cir_b, alpha: cir_alpha)
    }

}
