//
//  GameViewController.swift
//  ripple
//
//  Created by Brittany Ann Kos on 9/24/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //println("in viewDidLoad()\n")
        DataManager.createFile()
        
        // create notifications for application resign and active.  This will call those
        // functions (inside of this class) then the app is exited an started again.  This
        // persists throughout the app, no matter the scene
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "applicationWillResignActive:",
            name: UIApplicationWillResignActiveNotification,
            object: UIApplication.sharedApplication())
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "applicationDidBecomeActive:",
            name: UIApplicationDidBecomeActiveNotification,
            object: UIApplication.sharedApplication())
        
        
        let scene = GameStartScene(size: view.frame.size)
        //let scene = GameInstructionsScene(size: view.frame.size)
        //let scene = GameScene(size: view.frame.size)
        //let scene = GameOverScene(size: view.frame.size, newHighScore: true, score: 99)
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
        
    }
    
    
    
    func applicationWillResignActive(notification: NSNotification) {
    }
    
    func applicationDidBecomeActive(notification: NSNotification) {
        
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
