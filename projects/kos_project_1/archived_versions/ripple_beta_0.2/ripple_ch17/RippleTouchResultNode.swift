//
//  GainedPointsNode.swift
//  ripple_ch17
//
//  Created by Brittany Kos on 9/23/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class RippleTouchResultNode: SKNode {
    
    var amountNode = SKLabelNode(fontNamed: "helvetica")
    var text_alpha: CGFloat = 1.0
    
    init(x: CGFloat, y: CGFloat, text: String) {
        super.init()
        
        self.position = CGPoint(x: x, y: y)
        
        amountNode.fontSize = 16
        amountNode.fontColor = SKColor(white: 0, alpha: text_alpha)
        amountNode.text = text
        addChild(amountNode)

    }
    
    
    func updateAndDraw() {
        self.position.y += 1
        
        text_alpha -= 0.03
        amountNode.fontColor = SKColor(white: 0, alpha: text_alpha)
    }

    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
