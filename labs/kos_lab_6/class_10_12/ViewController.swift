//
//  ViewController.swift
//  class_10_12
//
//  Created by Brittany Kos on 10/15/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    var imageViews = [UIImageView]()
    var starSelected = false
    
    
    @IBAction func doLongPress(sender: UILongPressGestureRecognizer) {
        switch(sender.view!) {
        case star1: longPressHelper(0)
        case star2: longPressHelper(1)
        case star3: longPressHelper(2)
        case star4: longPressHelper(3)
        case star5: longPressHelper(4)
        default: break;
        }
        starSelected = !starSelected
    }
    
    func longPressHelper(img: Int) {
        if(!starSelected) {
            for(var i=0; i<5; i++) {
                if(i != img) {
                    imageViews[i].image = UIImage(named: "grey_star")
                }
            }
        } else {
            for(var i=0; i<5; i++) {
                imageViews[i].image = UIImage(named: "star")
            }
        }
        
    }
    
    @IBAction func doPinch(sender: UIPinchGestureRecognizer) {
        sender.view!.transform = CGAffineTransformScale(sender.view!.transform, sender.scale, sender.scale)
        sender.scale = 1 //resets scale
    }
    @IBAction func doRotate(sender: UIRotationGestureRecognizer) {
        sender.view!.transform = CGAffineTransformRotate(sender.view!.transform, sender.rotation)
        sender.rotation = 0 //reset rotation
    }

    @IBAction func doPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        //returns the new location
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        sender.setTranslation(CGPointZero, inView: view)
        //set the translation back to 0
        
        if sender.state == UIGestureRecognizerState.Ended { //when the move ends
            //figure out the velocity
            let velocity = sender.velocityInView(self.view)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 200
            
            //if the length is < 200, then decrease the base speed, otherwise increase it
            let slideFactor = 0.1 * slideMultiplier //increase for a greater slide
            
            //calculate a final point based on the velocity and the slideFactor
            var finalPoint = CGPoint(x:sender.view!.center.x + (velocity.x * slideFactor), y:sender.view!.center.y + (velocity.y * slideFactor))
            
            //make sure the final point is within the view’s bounds
            finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
            finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
            
            //animate the view
            UIView.animateWithDuration(Double(slideFactor * 2), delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {sender.view!.center = finalPoint }, completion: nil)
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true //allow multiple gestures to be recognized
    }
    
    
    
    override func viewDidLoad() {
        imageViews = [star1, star2, star3, star4, star5]

        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

