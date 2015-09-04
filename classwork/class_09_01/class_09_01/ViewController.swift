//
//  ViewController.swift
//  class_09_01
//
//  Created by Brittany Ann Kos on 9/1/15.
//  Copyright (c) 2015 Brittany Ann Kos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // close keyboard when clicked "done"
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    // close keyboard when background clicked
    @IBAction func backgroundTap(sender: UIControl){
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        numberField.resignFirstResponder()
        
    }

}

