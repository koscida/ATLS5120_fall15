//
//  ViewController.swift
//  class_08_27
//
//  Created by Brittany Ann Kos on 8/27/15.
//  Copyright (c) 2015 Brittany Ann Kos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var rightButton: UIButton!
    
    @IBAction func clickEvent(sender: UIButton) {
        // get the button that was clicked
        var buttonText = sender.titleLabel!.text!
        
        // change the label
        label.text = buttonText
        
        /////////// change the button that was clicked  ////////////////
        // get the numerical value of the button that was clicked
        var buttonNum = buttonText.toInt()!
        // add button's value
        //if(sender.accessibilityLabel! == "left") {
        if(sender == leftButton) {
            buttonNum++
        } else {
            buttonNum--
        }
        // convert the number back to a string
        var updateNum = String(buttonNum)
        // update the button's text
        sender.setTitle(updateNum, forState: .Normal)
        
    }

}

