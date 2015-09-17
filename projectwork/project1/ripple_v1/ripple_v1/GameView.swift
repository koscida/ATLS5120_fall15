//
//  GameView.swift
//  ripple_v1
//
//  Created by Brittany Kos on 9/4/15.
//  Copyright (c) 2015 Brittany Kos. All rights reserved.
//

import Foundation

import UIKit

extension UIColor {
    class func randomColor() -> UIColor {
        let red = CGFloat(Double((arc4random() % 256)) / 255)
        let green = CGFloat(Double((arc4random() % 256)) / 255)
        let blue = CGFloat(Double((arc4random() % 256)) / 255)
        return UIColor(red : red, green : green, blue : blue, alpha : 1.0)
    }
}

enum Shape : UInt {
    case Line = 0, Rect, Ellipse
}

enum DrawingColor : UInt {
    case Red = 0, Blue, Yellow, Green, Random
}

class GameView: UIView {
    var shape = Shape.Line
    var currentColor = UIColor.redColor()
    var useRandomColor = false
    
    //private let image = UIImage("iphone")
    private var firstTouchLocation:CGPoint = CGPointZero
    private var lastTouchLocation:CGPoint = CGPointZero
    
    
    
    
    /*
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if useRandomColor {
        currentColor = UIColor.randomColor()
        }
        let touch = touches.first as UITouch
        firstTouchLocation = touch.locationInView(self)
        lastTouchLocation = firstTouchLocation
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as UITouch
        lastTouchLocation = touch.locationInView(self)
        setNeedsDisplay()
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        let touch = touches.first as UITouch
        lastTouchLocation = touch.locationInView(self)
        setNeedsDisplay()
    }
    */
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if useRandomColor {
            currentColor = UIColor.randomColor()
        }
        let touch = touches.anyObject() as UITouch
        firstTouchLocation = touch.locationInView(self)
        lastTouchLocation = firstTouchLocation
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject()as UITouch
        lastTouchLocation = touch.locationInView(self)
        setNeedsDisplay()
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        let touch = touches.anyObject()as UITouch
        lastTouchLocation = touch.locationInView(self)
        //setNeedsDisplay()
    }
    
    
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetLineWidth(context, 2.0)
        CGContextSetStrokeColorWithColor(context, currentColor.CGColor)
        
        CGContextSetFillColorWithColor(context, currentColor.CGColor)
        let currentRect = CGRectMake(firstTouchLocation.x, firstTouchLocation.y, lastTouchLocation.x - firstTouchLocation.x, lastTouchLocation.y - firstTouchLocation.y)
        
        switch shape {
        case .Line :
            CGContextMoveToPoint(context, firstTouchLocation.x, firstTouchLocation.y)
            CGContextAddLineToPoint(context, lastTouchLocation.x, lastTouchLocation.y)
            CGContextStrokePath(context)
            
        case .Rect :
            CGContextAddRect(context, currentRect)
            CGContextDrawPath(context, kCGPathFillStroke)
            break
            
        case .Ellipse :
            CGContextAddEllipseInRect(context, currentRect)
            CGContextDrawPath(context, kCGPathFillStroke)
            break
            
        }
    }
    
    
}


