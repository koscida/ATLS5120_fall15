//
//  ViewController.swift
//  class_08_27_v2
//
//  Created by Brittany Ann Kos on 8/27/15.
//  Copyright (c) 2015 Brittany Ann Kos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var incra = 1.0;
    
    @IBOutlet weak var theScrollView: UIScrollView!
    
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
    
    
    /*
     * Action method to change the incrament values
     */
    @IBAction func changeIncrament(sender: AnyObject) {
        // get new incrament value
        incra = (incramentNum.selectedSegmentIndex == 0 ? 1.0 : (incramentNum.selectedSegmentIndex == 1 ? 5.0 : 10.0))
        
        // change the stepper incrament values
        r_change.stepValue = incra
        g_change.stepValue = incra
        b_change.stepValue = incra

    }
    
    
    /*
     * Action method for each of the steppers (- and + buttons)
     */
    @IBAction func changeColorValue(sender: UIStepper) {
   
        // get the values of all the color labels
        var rValue = r_color_dec.text!
        var rValueInt = rValue.toInt()!
        
        var gValue = g_color_dec.text!
        var gValueInt = gValue.toInt()!
        
        var bValue = b_color_dec.text!
        var bValueInt = bValue.toInt()!
        
        
        // check which color label is changing
        if(sender == r_change) {
            r_color_dec.text = Int(sender.value).description
            rValueInt += Int(incra)
            changeHexValue(r_color_hex, value: rValueInt)
        }
        if(sender == g_change) {
            g_color_dec.text = Int(sender.value).description
            gValueInt += Int(incra)
            changeHexValue(g_color_hex, value: gValueInt)
        }
        if(sender == b_change) {
            b_color_dec.text = Int(sender.value).description
            bValueInt += Int(incra)
            changeHexValue(b_color_hex, value: bValueInt)
        }
        
        
        // change the color block
        changeColorBlock(rValueInt, gValueInt: gValueInt, bValueInt: bValueInt);
        
    }
    
    
    /* 
     * Changes the color of the large color block (really a UIView)
     */
    func changeColorBlock(var rValueInt : Int, var gValueInt : Int, var bValueInt : Int) {
        // get color float values of int color values
        let newRed = CGFloat(rValueInt)/255
        let newGreen = CGFloat(gValueInt)/255
        let newBlue = CGFloat(bValueInt)/255
        
        // create new color
        let newColor = UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
        
        // change the color block
        colorBlock.backgroundColor = newColor
    }
    
    
    /*
     * Changes the hex value of the color that was changed
     */
    func changeHexValue(var label : UILabel, var value : Int) {
        // number 1
        var num1 = value/16;
        var str1 = convertDecToHex(num1);
        
        // number 2
        var num2 = value % 16;
        var str2 = convertDecToHex(num2);
        
        // concat
        label.text = str1 + str2;
    }
    // converts decimal numbers from 0-15 to their hex values
    func convertDecToHex(var num : Int) -> String {
        if(num <= 9) {
            return String(num)
        } else if (num == 10) {
            return "A"
        } else if (num == 11) {
            return "B"
        } else if (num == 12) {
            return "C"
        } else if (num == 13) {
            return "D"
        } else if (num == 14) {
            return "E"
        } else if (num == 15) {
            return "F"
        }
        return "-1"
    }
    
    
    /*
     * Action method to change the background color from black to white
     */
    @IBAction func change_background(sender: AnyObject) {
        var labelColor : UIColor;
        var backColor : UIColor;
        println("in here")
        
        // change background to white
        if (sender.selectedSegmentIndex == 0) {
            labelColor = UIColor.blackColor()
            backColor = UIColor.whiteColor()
            
        // change background to black
        } else {
            labelColor = UIColor.whiteColor()
            backColor = UIColor.blackColor()
        }
        
        // change label text colors
        for view1 in theScrollView.subviews as! [UIView] {
            if let lbl = view1 as? UILabel {
                lbl.textColor = labelColor
            }
        }
        
        // change background
        theScrollView.backgroundColor = backColor
        
    }
    
    
    

    
    /*
     * Default
     * Added stepper defaults
     */
    override func viewDidLoad() {
        // default
        super.viewDidLoad()
        
        
        // set up the steppers
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
        
        
        // set up the scroll view to scroll vertically
        theScrollView.contentSize.height = 680;
    }
    
    
    /*
     * default
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

