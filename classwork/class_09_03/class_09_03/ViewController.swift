//
//  ViewController.swift
//  class_09_03
//
//  Created by Brittany Ann Kos on 9/3/15.
//  Copyright (c) 2015 Brittany Ann Kos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func supportedInterfaceOrientations() -> Int {
        return
              Int(UIInterfaceOrientationMask.All.rawValue)
            | Int(UIInterfaceOrientationMask.PortraitUpsideDown.rawValue)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

