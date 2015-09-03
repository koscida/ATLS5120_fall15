//
//  ViewController.swift
//  class_08_27_v2
//
//  Created by Brittany Ann Kos on 8/27/15.
//  Copyright (c) 2015 Brittany Ann Kos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var colorBlock: UIView!
    
    @IBOutlet weak var incramentNum: UISegmentedControl!
    
    @IBOutlet weak var r_color_dec: UILabel!
    @IBOutlet weak var g_color_dec: UILabel!
    @IBOutlet weak var b_color_dec: UILabel!
    
    @IBOutlet weak var r_color_hex: UILabel!
    @IBOutlet weak var g_color_hex: UILabel!
    @IBOutlet weak var b_color_hex: UILabel!
    
    @IBOutlet weak var r_change: UIStepper!
    @IBOutlet weak var g_change: UIStepper!
    @IBOutlet weak var b_change: UIStepper!
    
    @IBAction func changeColorValue(sender: UIStepper) {
   
        // get the values of all the color labels
        var rValue = r_color_dec.text!
        var rValueInt = rValue.toInt()!
        
        var gValue = g_color_dec.text!
        var gValueInt = gValue.toInt()!
        
        var bValue = b_color_dec.text!
        var bValueInt = bValue.toInt()!
        
        // set the value to incrament by
        var incra = (incramentNum.selectedSegmentIndex == 0 ? 1.0 : (incramentNum.selectedSegmentIndex == 1 ? 5.0 : 10.0))
        sender.stepValue = incra
        
        // check which color label is changing
        if(sender == r_change) {
            r_color_dec.text = Int(sender.value).description
            rValueInt += Int(incra)
        }
        if(sender == g_change) {
            g_color_dec.text = Int(sender.value).description
            gValueInt += Int(incra)
        }
        if(sender == b_change) {
            b_color_dec.text = Int(sender.value).description
            bValueInt += Int(incra)
        }
        
        // change the color block
        changeColorBlock(rValueInt, gValueInt: gValueInt, bValueInt: bValueInt);
        
    }
    
    
    func changeColorBlock(var rValueInt : Int, var gValueInt : Int, var bValueInt : Int) {
        // change the color block
        let newRed = CGFloat(rValueInt)/255
        let newGreen = CGFloat(gValueInt)/255
        let newBlue = CGFloat(bValueInt)/255
        let newColor = UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
        colorBlock.backgroundColor = newColor
    }
    
    
    
    @IBAction func change_background(sender: AnyObject) {
        // chenge background to white
        if (sender.selectedSegmentIndex == 0) {
            self.view.backgroundColor = UIColor.whiteColor()
        // change background to black
        } else {
            self.view.backgroundColor = UIColor.blackColor()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        
        r_change.wraps = false
        r_change.autorepeat = true
        r_change.maximumValue = 255
        r_change.minimumValue = 0;
        
        g_change.wraps = false
        g_change.autorepeat = true
        g_change.maximumValue = 255
        g_change.minimumValue = 0;
        
        b_change.wraps = false
        b_change.autorepeat = true
        b_change.maximumValue = 255
        b_change.minimumValue = 0;
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

