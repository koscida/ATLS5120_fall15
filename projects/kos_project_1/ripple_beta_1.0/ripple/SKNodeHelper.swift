//
//  SkNodeHelper.swift
//  ripple
//
//  Created by Brittany Kos on 10/1/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import Foundation
import SpriteKit

class SKNodeHelper {
    
    static func blue() -> SKColor {
        return SKColor(red: 0, green: 0.6, blue: 1.0, alpha: 1)
    }
    
    
    
    static func createLabel(text: String, x: CGFloat, y: CGFloat, fontSize: CGFloat) -> SKLabelNode {
        return createLabel(text, x: x, y: y, fontSize: fontSize, color: SKColor.whiteColor(), name: "", zIndex: 0)
    }
    
    static func createLabel(text: String, x: CGFloat, y: CGFloat, fontSize: CGFloat, name: String) -> SKLabelNode {
        return createLabel(text, x: x, y: y, fontSize: fontSize, color: SKColor.whiteColor(), name: name, zIndex: 0)
    }
    
    static func createLabel(text: String, x: CGFloat, y: CGFloat, fontSize: CGFloat, color: SKColor) -> SKLabelNode {
        return createLabel(text, x: x, y: y, fontSize: fontSize, color: color, name: "", zIndex: 0)
    }
    
    static func createLabel(text: String, x: CGFloat, y: CGFloat, fontSize: CGFloat, color: SKColor, name: String) -> SKLabelNode {
        return createLabel(text, x: x, y: y, fontSize: fontSize, color: color, name: name, zIndex: 0)
    }
    
    static func createLabel(text: String, x: CGFloat, y: CGFloat, fontSize: CGFloat, zIndex: CGFloat) -> SKLabelNode {
        return createLabel(text, x: x, y: y, fontSize: fontSize, color: SKColor.whiteColor(), name: "", zIndex: zIndex)
    }
    
    static func createLabel(text: String, x: CGFloat, y: CGFloat, fontSize: CGFloat, color: SKColor, name: String, zIndex: CGFloat) -> SKLabelNode {
        let label = SKLabelNode(fontNamed: "Helvetica")
        label.text = text
        label.position = CGPointMake(x, y)
        label.fontSize = fontSize
        label.fontColor = color
        label.name = name
        label.zPosition = zIndex
        
        return label
    }
    
    
    
    
    
    static func createSquare(rect: CGRect, color: SKColor) -> SKShapeNode {
        return createSquare(rect, color: color, corners: 0, name: "", zIndex: 0)
    }
    
    static func createSquare(rect: CGRect, color: SKColor, corners: CGFloat) -> SKShapeNode {
        return createSquare(rect, color: color, corners: corners, name: "", zIndex: 0)
    }
    
    static func createSquare(rect: CGRect, color: SKColor, name: String) -> SKShapeNode {
        return createSquare(rect, color: color, corners: 0, name: name, zIndex: 0)
    }
    
    static func createSquare(rect: CGRect, color: SKColor, corners: CGFloat, name: String) -> SKShapeNode {
        return createSquare(rect, color: color, corners: corners, name: name, zIndex: 0)
    }
    
    static func createSquare(rect: CGRect, color: SKColor, name: String, zIndex: CGFloat) -> SKShapeNode {
        return createSquare(rect, color: color, corners: 0, name: name, zIndex: zIndex)
    }
    
    static func createSquare(rect: CGRect, color: SKColor, corners: CGFloat, name: String, zIndex: CGFloat) -> SKShapeNode {
        let shape = SKShapeNode(rect: rect, cornerRadius: corners)
        shape.fillColor = color
        shape.name = name
        shape.zPosition = zIndex
        shape.lineWidth = 0
        
        return shape
    }
    
    
}