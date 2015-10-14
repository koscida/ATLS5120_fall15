//
//  DataManager.swift
//  ripple
//
//  Created by Brittany Kos on 9/28/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import Foundation
import SpriteKit

class DataManager {

    static func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = paths[0] as! NSString
        return documentsDirectory.stringByAppendingPathComponent("data.plist") as String
    }
    
    static func fileExists() -> Bool {
        var array = getData()
        return !array.isEmpty
    }
    
    
    
    static func saveData(array: Array<String>) {
        var a: NSArray = array
        let filePath = DataManager.dataFilePath()
        a.writeToFile(filePath, atomically: true)
    }
    
    static func getData() -> Array<String> {
        let filePath = dataFilePath()
        if (NSFileManager.defaultManager().fileExistsAtPath(filePath)) {
            let array = NSArray(contentsOfFile: filePath) as! [String]
            return array
        }
        return []
    }
    
    
    
    
    static func createFile() {
        var array = getData()
        
        if(array.isEmpty) {
            
            // highest points
            array.append("0")
            
            // good color
            array.append("0.98")
            array.append("0.52")
            array.append("0.05")
            
            // bad color
            array.append("0.4")
            array.append("0.4")
            array.append("0.4")
        }
        
        saveData(array)
    }
    
    
    
    
    static func getHighPoints() -> String {
        let array = getData()
        if(array.isEmpty) {
            return "0"
        } else {
            return array[0] as String
        }
    }
    
    static func getGoodColor() -> SKColor {
        return getGenericColor(true)
    }
    
    static func getBadColor() -> SKColor {
        return getGenericColor(false)
    }
    
    static func getGenericColor(good: Bool) -> SKColor {
        var i = (good) ? 1 : 4
        var array = getData()
        if(!array.isEmpty) {
            var r = CGFloat(NSNumberFormatter().numberFromString(array[i])!)
            var g = CGFloat(NSNumberFormatter().numberFromString(array[i+1])!)
            var b = CGFloat(NSNumberFormatter().numberFromString(array[i+2])!)
            return SKColor(red: r, green: g, blue: b, alpha: 1.0)
        }
        return SKColor(red: 0.8, green: 0.52, blue: 0.05, alpha: 1.0)
    }
    
    
    
    
    static func saveHighPoints(points: String) {
        var array = getData()
        array[0] = points
        saveData(array)
    }
    
    static func saveColors(goodColor: SKColor, badColor: SKColor) {
        var array = getData()
        
        var nodeRed: CGFloat = 0
        var nodeGreen: CGFloat = 0
        var nodeBlue: CGFloat = 0
        var nodeAlpha: CGFloat = 0
        
        goodColor.getRed(&nodeRed, green: &nodeGreen, blue: &nodeBlue, alpha: &nodeAlpha)
        array[1] = "\(nodeRed)"
        array[2] = "\(nodeGreen)"
        array[3] = "\(nodeBlue)"
        
        badColor.getRed(&nodeRed, green: &nodeGreen, blue: &nodeBlue, alpha: &nodeAlpha)
        array[4] = "\(nodeRed)"
        array[5] = "\(nodeGreen)"
        array[6] = "\(nodeBlue)"
        
        saveData(array)
    }

}