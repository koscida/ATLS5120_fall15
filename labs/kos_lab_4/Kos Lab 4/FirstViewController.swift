//
//  FirstViewController.swift
//  Kos Lab 4
//
//  Created by Brittany Kos on 10/7/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

/*
Lab 4: Create an app that animates an image using Core Graphics for translation, 
rotation, or scaling(you only have to implement one of these). Your app should 
support portrait and landscape orientations, and include app icons and a launch screen.
*/

import UIKit

/* ******************** */
/*      Translation     */
/* ******************** */
class FirstViewController: UIViewController {
    
    
    /*
    var delta = CGPointMake(12, 4) //initialize the delta to move 12 pixels horizontally, 4 pixels vertically
    var ballRadius = CGFloat() //radius of the ball image

    @IBOutlet weak var slider: UIStepper!
    @IBOutlet weak var sliderLabel: UILabel!
    
    
    //changes the position of the image view
    func moveImage() {
        let duration = Double(slider.value)
        UIView.beginAnimations("tennis_ball", context: nil)
        UIView.animateWithDuration(duration, animations: {self.imageView.center = CGPointMake(self.imageView.center.x + self.delta.x, self.imageView.center.y + self.delta.y)} )
        UIView.commitAnimations()
        
        
        if imageView.center.x > view.bounds.size.width - ballRadius || imageView.center.x < ballRadius {
                delta.x = -delta.x
        }
        if imageView.center.y > view.bounds.size.height - ballRadius || imageView.center.y < ballRadius {
                delta.y = -delta.y
        }
    }
    
     
    //updates the timer and label with the current slider value
    @IBAction func changeSliderValue() {
        sliderLabel.text = String(format: "%.2f", slider.value)
        timer = NSTimer.scheduledTimerWithTimeInterval(Double(slider.value), target: self, selector: "moveImage", userInfo: nil, repeats: false)
    }
    
    @IBAction func sliderMoved(sender: UIStepper) {
        timer.invalidate()
        changeSliderValue()
    }
    */
    
    // copied code from 
    // http://stackoverflow.com/questions/25973137/swift-multiple-nstimers
    
    
    class TimerManager {
        
        var _timerTable = [NSTimer]()
        var _id: Int = 0
        
        func addTimer(t: NSTimer) {
            println("in addTimer()")
            _timerTable.append(t)
        }
        
        func runTimers() {
            println("in runTimers()")
            for t in _timerTable {
                t.fire()
            }
        }
        
        func stopTimers() {
            for t in _timerTable {
                t.invalidate()
            }
        }
        
        func deleteTimers() {
            _timerTable.removeAll()
        }
        
        /*func startTimer(target: AnyObject, selector: Selector, interval: NSTimeInterval) -> Int {
            var timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: target, selector: selector, userInfo: nil, repeats: false)
            _id += 1
            _timerTable[_id] = timer
            return _id
        }
        
        func stopTimer(id: Int) {
            if let timer = _timerTable[id] {
                if timer.valid {
                    timer.invalidate()
                }
            }
        }
        
        func getTimer(id: Int) -> NSTimer? {
            return _timerTable[id]
        }*/
        
        
        
        
    }
    
    // This needs to be delcared at global scope, serving as "singleton" instance of TimerManager
    //let timerManager = TimerManager()
    var _timerTable = [NSTimer]()
    
    // end copied code
    
    
    
    var timer = NSTimer()
    var duration: Double = 0.5
    
    
    
    
    @IBOutlet weak var flower: UIImageView!
    
    @IBOutlet weak var movesView: UITextView!
    
    @IBOutlet weak var move_up: UIButton!
    @IBOutlet weak var move_down: UIButton!
    @IBOutlet weak var move_right: UIButton!
    @IBOutlet weak var move_left: UIButton!
    @IBOutlet weak var move_go: UIButton!
    @IBOutlet weak var move_clear: UIButton!
    
    var movesArray = [Int]()
    
    @IBAction func addMove(sender: UIButton) {
        
        var text = movesView.text
        var move: String = ""
        
        switch(sender) {
        case move_up:
            move = "Up "
            movesArray.append(1)
            break;
        case move_down:
            move = "Down "
            movesArray.append(2)
            break;
        case move_right:
            move = "Right "
            movesArray.append(3)
            break;
        case move_left:
            move = "Left "
            movesArray.append(4)
            break;
        default:
            move = ""
            break;
        }
        
        movesView.text = text + move
    }
    
    @IBAction func clickClear(sender: UIButton) {
        movesView.text = ""
        timer.invalidate()
        movesArray = [Int]()
    }
    
    
    
    
    @IBAction func clickGo(sender: UIButton) {
        println("in clickGo")
        timer.invalidate()
        
        timer = NSTimer(timeInterval: 1.0, target: self, selector: "moveFlower1", userInfo: nil, repeats: false)
        timer.fire()
        
    }
    
    
    
    
    //changes the position of the image view
    func moveFlower1() {
        println("in moveFlower1")
        
        UIView.beginAnimations("flower", context: nil)
        for(var i=0; i<movesArray.count; i++) {
            println("in moveFlower1 for loop")
            
            switch(movesArray[i]) {
            case 1: UIView.animateWithDuration(0.3, animations: {self.flower.center = CGPointMake(self.flower.center.x +  0, self.flower.center.y - 68)} )
            case 2: UIView.animateWithDuration(0.3, animations: {self.flower.center = CGPointMake(self.flower.center.x +  0, self.flower.center.y + 68)} )
            case 3: UIView.animateWithDuration(0.3, animations: {self.flower.center = CGPointMake(self.flower.center.x + 68, self.flower.center.y +  0)} )
            case 4: UIView.animateWithDuration(0.3, animations: {self.flower.center = CGPointMake(self.flower.center.x - 68, self.flower.center.y +  0)} )
            default: break;
            }
        }
        UIView.commitAnimations()
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //ball radius is half the width of the image
        //ballRadius = imageView.frame.size.width/2
        //changeSliderValue()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

