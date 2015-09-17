//
//  PlayerNode.swift
//  ripple_ch17
//
//  Created by Brittany Kos on 9/15/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class PlayerNode: SKNode {
   override init() {
        super.init()
        name = "Player \(self)"
        initNodeGraph()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initNodeGraph() {
        let label = SKLabelNode(fontNamed: "Courier")
        label.fontSize = 40
        label.fontColor = SKColor.darkGrayColor()
        label.text = "v"
        label.name = "label"
        label.zRotation = CGFloat(M_PI)
        self.addChild(label)
    }
}
