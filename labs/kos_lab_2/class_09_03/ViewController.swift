//
//  ViewController.swift
//  class_09_03
//
//  Created by Brittany Ann Kos on 9/3/15.
//  Copyright (c) 2015 Brittany Ann Kos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //let screenSize: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    let screenSize: CGRect = UIScreen.mainScreen().bounds

    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    
    let container1 = UIView()
    let redSquare = UIView()
    let blueSquare = UIView()
    var redOnTop = true;
    
    let container2 = UIView()
    let purpleSquare = UIView()
    var purpleTurned = false;
    
    let container3 = UIView()
    let orangeSquare = UIView()
    let greenSquare = UIView()
    var orangeOnTop = true;
    
    
    @IBOutlet weak var yellow_block: UILabel!
    @IBOutlet weak var yellow_image: UIImageView!
    @IBAction func yellow_switch(sender: UISwitch) {
        if(!sender.on) {
            yellow_image.alpha = 1.0
        } else {
            yellow_block.backgroundColor = UIColor(red: (248/255.0), green: 1.0, blue: (81/255.0), alpha: 1.0)
            yellow_image.alpha = 0.0
            
        }
    }
    
    @IBOutlet weak var teal_label: UILabel!
    @IBAction func teal_slider(sender: UISlider) {
        var r_val = CGFloat(sender.value)
        var r_fl = r_val / 255.0;
        teal_label.backgroundColor = UIColor(red: r_fl, green: 1.0, blue: 221/255.0, alpha: 1.0)
        
    }
    
    
    @IBOutlet weak var one_label: UILabel!
    @IBOutlet weak var one_label_2: UILabel!
    @IBOutlet weak var two_label: UILabel!
    @IBOutlet weak var three_label: UILabel!
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBAction func changeTop(sender: AnyObject) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            let views1: (frontView: UIView, backView: UIView);
            if(self.redOnTop) {
                views1 = (frontView: self.redSquare, backView: self.blueSquare)
            } else {
                views1 = (frontView: self.blueSquare, backView: self.redSquare)
            }
            
            UIView.transitionWithView(self.container1, duration: 0.7, options: UIViewAnimationOptions.TransitionCurlUp, animations: {
                views1.frontView.removeFromSuperview()
                self.container1.addSubview(views1.backView)
                
                self.redOnTop = !self.redOnTop
                
                }, completion: nil )
            
        case 1:
            let turn:CGFloat = 180
            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {

                self.purpleSquare.transform = CGAffineTransformMakeRotation((turn * CGFloat(M_PI)) / turn)
                self.purpleTurned = !self.purpleTurned
                
                }, completion: nil)
            
        case 2:
            let views3: (frontView: UIView, backView: UIView);
            if(self.orangeOnTop) {
                views3 = (frontView: self.orangeSquare, backView: self.greenSquare)
            } else {
                views3 = (frontView: self.greenSquare, backView: self.orangeSquare)
            }
            
            UIView.transitionWithView(self.container3, duration: 0.7, options: UIViewAnimationOptions.TransitionCurlDown, animations: {
                views3.frontView.removeFromSuperview()
                self.container3.addSubview(views3.backView)
                
                self.orangeOnTop = !self.orangeOnTop
                
                }, completion: nil )
            
        default:
            break
        }
    }
    
    
    override func supportedInterfaceOrientations() -> Int {
        return
              Int(UIInterfaceOrientationMask.All.rawValue)
            | Int(UIInterfaceOrientationMask.PortraitUpsideDown.rawValue)
    }
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            println("landscape")
            create_red_blue_squares(false)
        } else {
            println("portraight")
            create_red_blue_squares(true)
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // get screen size
        //screenSize = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        // change yellow image to be transparent
        yellow_image.alpha = 0.0
        
        // create container/red/blue squares and add red to container
        create_red_blue_squares(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func create_red_blue_squares(por : Bool) {
        println("redraw")
        
        // reset containers
        self.container1.removeFromSuperview()
        self.container2.removeFromSuperview()
        self.container3.removeFromSuperview()

        
        // get the sizes of blocks
        var thirdWidth: CGFloat = 0;
        var thirdHeight: CGFloat = 0;
        
        if(por) {
            thirdWidth = (screenWidth * (1/3)) - 16
            thirdHeight = (screenHeight * (1/3)) - 16
        } else {
            thirdWidth = (screenHeight * (1/3)) - 16
            thirdHeight = (screenWidth * (1/3)) - 16
        }
        
        
        
        // create container for first block
        self.container1.frame = CGRect(x: 16, y: 8, width: thirdWidth, height: thirdHeight)
        self.view.addSubview(container1)
        
        // create blocks
        self.redSquare.frame = CGRect(x: 0, y: 0, width: thirdWidth, height: thirdHeight)
        self.blueSquare.frame = redSquare.frame
        
        // set background colors
        self.redSquare.backgroundColor = UIColor.redColor()
        self.blueSquare.backgroundColor = UIColor.blueColor()
        
        // add blocks
        if(self.redOnTop) {
            self.container1.addSubview(self.redSquare)
        } else {
            self.container1.addSubview(self.blueSquare)
        }
        
        
        
        
        // create container for second block
        self.container2.frame = CGRect(x: 16 + (thirdWidth + 8), y: 8, width: thirdWidth, height: thirdHeight)
        self.view.addSubview(container2)
        
        // create block
        self.purpleSquare.frame = CGRect(x: 0, y: 0, width: thirdWidth, height: thirdHeight)
        self.purpleSquare.backgroundColor = UIColor.purpleColor()
        self.container2.addSubview(self.purpleSquare)
        
        
        
        
        // create container for third block
        self.container3.frame = CGRect(x: 16 + ((thirdWidth + 8)*2), y: 8, width: thirdWidth, height: thirdHeight)
        self.view.addSubview(container3)
        
        // create blocks
        self.orangeSquare.frame = CGRect(x: 0, y: 0, width: thirdWidth, height: thirdHeight)
        self.orangeSquare.backgroundColor = UIColor.orangeColor()
        self.greenSquare.frame = CGRect(x: 0, y: 0, width: thirdWidth, height: thirdHeight)
        self.greenSquare.backgroundColor = UIColor.greenColor()
        (orangeOnTop) ? self.container3.addSubview(self.orangeSquare) : self.container3.addSubview(self.greenSquare)
        
        // change seg control to be on top
        self.view.addSubview(segControl)

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

