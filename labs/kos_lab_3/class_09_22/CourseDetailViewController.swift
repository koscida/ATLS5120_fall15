//
//  CourseDetailViewController.swift
//  class_09_22
//
//  Created by Brittany Kos on 9/22/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import UIKit

class CourseDetailViewController: UIViewController {
    
    var name: String = ""
    var enrol: Bool = false
    var cred: Float = 0.0
    var lett: String = ""
    var num: Float = 0.0
    

    @IBOutlet weak var courseTitle: UITextField!
    @IBOutlet weak var enrolledSwitch: UISwitch!
    @IBOutlet weak var credits: UITextField!
    @IBOutlet weak var letterGrade: UITextField!
    @IBOutlet weak var numGrade: UITextField!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var letGradeLabel: UILabel!
    @IBOutlet weak var numGradeLabel: UILabel!
    
    // switch "currently enrolled"
    @IBAction func switchEnrollment(sender: UISwitch) {
        if sender.on {
            credits.enabled = false
            letterGrade.enabled = false
            numGrade.enabled = false
            creditLabel.enabled = false
            letGradeLabel.enabled = false
            numGradeLabel.enabled = false
        } else {
            credits.enabled = true
            letterGrade.enabled = true
            numGrade.enabled = true
            creditLabel.enabled = true
            letGradeLabel.enabled = true
            numGradeLabel.enabled = true
        }
    }
   
    
    
    
    // keyboard click done
    @IBAction func textFieldDoneEditing(sender: UITextField) {
        validateText(sender)
        
        sender.resignFirstResponder()
    }
    
    // tap on background
    @IBAction func backgroundTap(sender: UIControl) {
        courseTitle.resignFirstResponder()
        credits.resignFirstResponder()
        letterGrade.resignFirstResponder()
        numGrade.resignFirstResponder()
    }
    
    
    func validateText(sender: UIControl) {
        
        if(sender == letterGrade) {
            var letter_upper = letterGrade.text.uppercaseString
            switch (letter_upper) {
            case "A":  numGrade.text = "4.0"
            case "A-": numGrade.text = "3.7"
                
            case "B+": numGrade.text = "3.3"
            case "B":  numGrade.text = "3.0"
            case "B-": numGrade.text = "2.7"
                
            case "C+": numGrade.text = "2.3"
            case "C":  numGrade.text = "2.0"
            case "C-": numGrade.text = "1.7"
                
            case "D+": numGrade.text = "1.3"
            case "D":  numGrade.text = "1.0"
            case "D-": numGrade.text = "0.7"
            case "F":  numGrade.text = "0.0"
                
            default:
                let alertController = UIAlertController(title: "Error", message: "Invalid letter grade entered", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: {action in
                    self.letterGrade.text = ""
                    self.numGrade.text = ""
                }))
                alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
        
        if (sender == numGrade) {
            switch ((numGrade.text as NSString).floatValue) {
            case 4.0:  letterGrade.text = "A"
            case 3.7: letterGrade.text = "A-"
                
            case 3.3: letterGrade.text = "B+"
            case 3.0:  letterGrade.text = "B"
            case 2.7: letterGrade.text = "B-"
                
            case 2.3: letterGrade.text = "C+"
            case 2.0:  letterGrade.text = "C"
            case 1.7: letterGrade.text = "C-"
                
            case 1.3: letterGrade.text = "D+"
            case 1.0:  letterGrade.text = "D"
            case 0.7: letterGrade.text = "D-"
            case 0.0:  letterGrade.text = "F"
                
            default:
                let alertController = UIAlertController(title: "Error", message: "Invalid numeric grade entered", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: {action in
                    self.letterGrade.text = ""
                    self.numGrade.text = ""
                }))
                alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }

        }
        
        if(sender == credits) {
            if ((credits.text as NSString).floatValue) < 0.0 {
                let alertController = UIAlertController(title: "Error", message: "Cannot have negative credit hours", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: {action in
                    self.credits.text = "0"
                }))
                alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }

        }

    } // end validate text
    

    
    // MARK: - Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        
        if identifier == "doneSegue" {
            
            if (courseTitle.text.isEmpty ||
                (!enrolledSwitch.on && (credits.text.isEmpty || letterGrade.text.isEmpty || numGrade.text.isEmpty))
                
            ) {
                
                let alert = UIAlertView()
                alert.title = "Error"
                alert.message = "Please fill out all text fields"
                alert.addButtonWithTitle("Ok")
                alert.show()
                
                return false
            }
                
            else {
                name = courseTitle.text
                enrol = enrolledSwitch.on
                cred = (credits.text as NSString).floatValue
                lett = letterGrade.text
                num = (numGrade.text as NSString).floatValue
                
                return true
            }
        }
        
        // by default, transition
        return true
    }
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "doneSegue" {
            name = courseTitle.text
            enrol = enrolledSwitch.on
            cred = (credits.text as NSString).floatValue
            lett = letterGrade.text
            num = (numGrade.text as NSString).floatValue
        }
    }
    */
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
