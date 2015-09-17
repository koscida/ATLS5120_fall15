//
//  ViewController.swift
//  ripple_v1
//
//  Created by Brittany Kos on 9/4/15.
//  Copyright (c) 2015 Brittany Kos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var colorControl: UISegmentedControl!
    
    @IBAction func changeColor(sender: UISegmentedControl) {
        let drawingColorSelection = DrawingColor(rawValue: UInt(sender.selectedSegmentIndex))
        //println(drawingColorSelection?.rawValue)
        
        if let drawingColor = drawingColorSelection {
            let funView = view as GameView
            switch drawingColor {
                case .Red:
                    funView.currentColor = UIColor.redColor()
                    funView.useRandomColor = false
                
                case .Blue:
                    funView.currentColor = UIColor.blueColor()
                    funView.useRandomColor = false
                
                case .Yellow:
                    funView.currentColor = UIColor.yellowColor()
                    funView.useRandomColor = false
                
                case .Green:
                    funView.currentColor = UIColor.greenColor()
                    funView.useRandomColor = false
                
                case .Random:
                    funView.useRandomColor = true
                
                default:
                    break
                
            }
        }
    }

    @IBAction func changeShape(sender: UISegmentedControl) {
        let shapeSelection = Shape(rawValue: UInt(sender.selectedSegmentIndex))
        //println(shapeSelection?.rawValue)
        
        if let shape = shapeSelection {
            let funView = view as GameView
            funView.shape = shape
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UIFont(name: "MeriendaOne-Regular", size: 35)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }


}

