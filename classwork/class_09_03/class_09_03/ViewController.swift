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
    
    let container = UIView()
    let redSquare = UIView()
    let blueSquare = UIView()

    
    
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
    @IBAction func changeTop(sender: AnyObject) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            
            // create a 'tuple' (a pair or more of objects assigned to a single variable)
            let views = (frontView: self.redSquare, backView: self.blueSquare)
            
            // set a transition style
            let transitionOptions = UIViewAnimationOptions.TransitionCurlUp
            
            UIView.transitionWithView(self.container, duration: 1.0, options: transitionOptions, animations: {
                // remove the front object...
                views.frontView.removeFromSuperview()
                
                // ... and add the other object
                self.container.addSubview(views.backView)
                
                }, completion: { finished in
                    // any code entered here will be applied
                    // .once the animation has completed
            })
            
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
        create_red_blue_squares(false)
        
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            println("landscape")
            
        } else {
            println("portraight")
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
        println("redraw");
        
        self.container.removeFromSuperview()
        
        var thirdWidth: CGFloat = 0;
        var thirdHeight: CGFloat = 0;
        
        if(por) {
            thirdWidth = (screenWidth * (1/3)) - 16
            thirdHeight = (screenHeight * (1/3)) - 16
        } else {
            thirdWidth = (screenHeight * (1/3)) - 16
            thirdHeight = (screenWidth * (1/3)) - 16
        }
        
        // set container frame and add to the screen
        self.container.frame = CGRect(x: 16, y: 8, width: thirdWidth, height: thirdHeight)
        self.view.addSubview(container)
        
        // set red square frame up
        // we want the blue square to have the same position as redSquare
        // so lets just reuse blueSquare.frame
        self.redSquare.frame = CGRect(x: 0, y: 0, width: thirdWidth, height: thirdHeight)
        self.blueSquare.frame = redSquare.frame
        
        // set background colors
        self.redSquare.backgroundColor = UIColor.redColor()
        self.blueSquare.backgroundColor = UIColor.blueColor()
        
        // for now just add the redSquare
        // we'll add blueSquare as part of the transition animation
        self.container.addSubview(self.redSquare)
    }

}

