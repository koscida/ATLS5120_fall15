//
//  ViewController.swift
//  class_08_25
//
//  Created by Brittany Kos on 8/25/15.
//  Copyright (c) 2015 Brittany Kos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        // get the title of the button - force unwrap it (force the value)
        var title = sender.titleForState(.Normal)!
        // plainText is equal title + string
        var plainText = title + "button pressed"
        // set the text in the label
        //statusLabel.text = plainText
        
        // create a attributed string out of the plain text string
        let styledText = NSMutableAttributedString(string: plainText)
        // create an array of attributes
        let attributes = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(statusLabel.font.pointSize)
        ]
        // type cast plainText to NSString class
        // create nameRange, which will be range of starting and ending index of title within the string
        let nameRange = (plainText as NSString).rangeOfString(title)
        // set the style attributes to the range (substring)
        styledText.setAttributes(attributes, range: nameRange)
        // set the attributed string in the label
        statusLabel.attributedText = styledText
    }

}

