//
//  ViewController.swift
//  kos_midterm
//
//  Created by Brittany Ann Kos on 10/29/15.
//  Copyright (c) 2015 Brittany Ann Kos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var commuteMilesField: UITextField!
    @IBOutlet weak var showMonthlySwitch: UISwitch!
    @IBOutlet weak var gasTankSlider: UISlider!
    @IBOutlet weak var gasTankLabel: UILabel!
    @IBOutlet weak var vehicleSeg: UISegmentedControl!
    
    @IBOutlet weak var totalCommuteTimeLabel: UILabel!
    @IBOutlet weak var totalCommuteTime: UILabel!
    @IBOutlet weak var gasBuyLabel: UILabel!
    @IBOutlet weak var gasBuy: UILabel!
    
    @IBOutlet weak var vehicleImage: UIImageView!
    
    @IBOutlet weak var infoBtn: UIBarButtonItem!
    
    
    var commuteTimeDaily: Float = 0
    var commuteMilesDaily: Float = 0
    var necessaryGasDaily: Float = 0
    
    var commuteTimeMonthly: Float = 0
    var commuteMilesMonthly: Float = 0
    var necessaryGasMonthly: Float = 0
    
    var doCalculation: Bool = true
    
    var gasInTank: Float = 0
    
    var travelByCar = false
    var travelByBus = false
    var travelByBike = false
    
    
    
    @IBAction func changeVehicle(sender: UISegmentedControl) {
        travelByCar = false
        travelByBus = false
        travelByBike = false
        
        // change images when change vehicle type
        if(sender.selectedSegmentIndex == 0) {
            vehicleImage.image = UIImage(named: "car_icon")
            travelByCar = true
        } else if(sender.selectedSegmentIndex == 1) {
            vehicleImage.image = UIImage(named: "bus_icon")
            travelByBus = true
            gasBuy.text = "0 gallons!"
        } else if(sender.selectedSegmentIndex == 2) {
            vehicleImage.image = UIImage(named: "bike_icon")
            travelByBus = true
            gasBuy.text = "0 gallons!"
        }
    }
    
    
    @IBAction func changeGasTank(sender: UISlider) {
        gasInTank = Float(sender.value)
        var gasString = String(format: "%.1f", gasInTank)
        gasTankLabel.text = gasString + " gal"
    }
    
    @IBAction func changeShowMonthly(sender: UISwitch) {
        // if on, then show monthly
        if(sender.on) {
            totalCommuteTimeLabel.text = "Commute time (monthly)"
            gasBuyLabel.text = "Gas to buy (monthly)"
        // else, then show daily
        } else {
            totalCommuteTimeLabel.text = "Commute time (daily)"
            gasBuyLabel.text = "Gas to buy (daily)"
        }
    }
    
    
    
    
    // Big calculate button!!
    @IBAction func calculateCommute(sender: UIButton) {
        // get rount-trip commute miles
        commuteMilesDaily = (commuteMilesField.text as NSString).floatValue
        
        // check if commuting over 50 miles, and ask if serious
        if(commuteMilesDaily >= 50 && travelByCar) {
        
            let optionMenu = UIAlertController(title: nil, message: "Do you hate the trees and breathing oxygen?  Cause it looks like you do.  Did you really travel over 50 miles to work daily?", preferredStyle: .ActionSheet)
            
            let yesAction = UIAlertAction(title: "Yes", style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.doCalculation = true
            })
            let noAction = UIAlertAction(title: "No", style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.doCalculation = false
                self.commuteMilesField.text = ""
            })
            
            optionMenu.addAction(yesAction)
            optionMenu.addAction(noAction)
            
            self.presentViewController(optionMenu, animated: true, completion: nil)
        }
        
        
        if(doCalculation) {
            //////////////////////////////////////////////////////////////
            //      calculate commute time (both daily and monthly)     //
            if(travelByCar) {
                // (1 hour / 20 miles) * (# travel miles)
                commuteTimeDaily = (1/20) * commuteMilesDaily
            } else if (travelByBus) {
                // ((1 hour / 12 miles) * (# travel miles)) + 10 min wait
                commuteTimeDaily = ((1/12) * commuteMilesDaily) + 10
            } else if (travelByBike) {
                // (1 hour / 10 miles) * (# travel miles)
                commuteTimeDaily = (1/10) * commuteMilesDaily
            }
            
            
            // if show monthly switch is on, take 20 days into account
            if(showMonthlySwitch.on) {
                // finish calculation of commute miles for the month and store in label
                commuteTimeMonthly = commuteTimeMonthly * 20
                totalCommuteTime.text = "\(commuteTimeMonthly) min"
                
                if(travelByCar) {
                    //////////////////////////////////////
                    //      calculate necessary gas     //
                    // (1 gal / 24 miles) * (# travel miles) * 20 days
                    necessaryGasDaily = (1/24) * commuteMilesDaily
                    necessaryGasMonthly = necessaryGasDaily * 20
                    gasBuy.text = "\(necessaryGasMonthly) gallons"
                    
                    ///////////////////////////////////////
                    //      pop-up if not enough gas     //
                    if(necessaryGasDaily > gasInTank) {
                        let alertController = UIAlertController(title: "Warning", message:
                            "You do not have enough gas to make a single round-trip.", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    } else if (necessaryGasMonthly > gasInTank) {
                        let alertController = UIAlertController(title: "Warning", message:
                            "You do not have enough gas to make a month's worth of round-trips.", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                }
                
            // else daily calculations
            } else {
                // store commute time in label
                totalCommuteTime.text = "\(commuteTimeDaily) min"
                
                if(travelByCar) {
                    //////////////////////////////////////
                    //      calculate necessary gas     //
                    // (1 gal / 24 miles) * (# travel miles)
                    necessaryGasDaily = (1/24) * commuteMilesDaily
                    gasBuy.text = "\(necessaryGasDaily) gallons"
                    
                    ///////////////////////////////////////
                    //      pop-up if not enough gas     //
                    if(necessaryGasDaily > gasInTank) {
                        let alertController = UIAlertController(title: "Warning", message:
                            "You do not have enough gas to make a round-trip.", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    @IBAction func textFieldDoneEditing(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func backgroundTap(sender: UIControl) {
        commuteMilesField.resignFirstResponder()
    }
    
}

