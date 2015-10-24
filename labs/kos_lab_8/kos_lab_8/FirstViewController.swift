//
//  ViewController.swift
//  kos_lab_8
//
//  Created by Brittany Kos on 10/23/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var sign = ""
    var signNum = 0;

    @IBOutlet weak var birthdate: UIDatePicker!
    @IBOutlet weak var showHoroscope: UIButton!
    
    @IBOutlet weak var aries: UILabel!
    @IBOutlet weak var taurus: UILabel!
    @IBOutlet weak var gemini: UILabel!
    @IBOutlet weak var cancer: UILabel!
    @IBOutlet weak var leo: UILabel!
    @IBOutlet weak var virgo: UILabel!
    @IBOutlet weak var libra: UILabel!
    @IBOutlet weak var scorpio: UILabel!
    @IBOutlet weak var sagittarius: UILabel!
    @IBOutlet weak var capricorn: UILabel!
    @IBOutlet weak var aquarius: UILabel!
    @IBOutlet weak var pisces: UILabel!
    
    var signLabels = [UILabel]();
    
    
    @IBAction func pickDate(sender: UIDatePicker) {
        setSign()
    }
    
    func setSign() {
        if(signNum != 0) {
            signLabels[signNum-1].textColor = UIColor.blackColor()
        }
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "MM"
        var dMonth: Int = (dateFormatter.stringFromDate(birthdate.date)).toInt()!
        
        dateFormatter.dateFormat = "dd"
        var dDay: Int = (dateFormatter.stringFromDate(birthdate.date)).toInt()!
        
        
        /*
        Aries - The Ram
        March 21 - April 19
        
        Taurus - The Bull
        April 20 - May 20
        
        Gemini - The Twins
        May 21 - June 20
        
        Cancer - The Crab
        June 21 - July 22
        
        Leo - The Lion
        July 23 - August 22
        
        Virgo - The Virgin
        August 23 - September22
        
        Libra - The Scales
        September 23 - October 22
        
        Scorpio - The Scorpion
        October 23 - November 21
        
        Sagittarius - The Centaur
        November 22 - December 21
        
        Capricorn - The Goat
        December 22 - January 19
        
        Aquarius - The Water Bearer
        January 20 - February 18
        
        Pisces - The Fish
        February 19 - March 20
        */
        
        
        if( (dMonth == 03 && dDay >= 21) || (dMonth == 04 && dDay <= 19) ){
            sign = "Aries - The Ram"
            signNum = 1
        } else if( (dMonth == 04 && dDay >= 20) || (dMonth == 05 && dDay <= 20) ){
            sign = "Taurus - The Bull"
            signNum = 2
        } else if( (dMonth == 05 && dDay >= 21) || (dMonth == 06 && dDay <= 20) ){
            sign = "Gemini - The Twins"
            signNum = 3
        } else if( (dMonth == 06 && dDay >= 21) || (dMonth == 07 && dDay <= 22) ){
            sign = "Cancer - The Crab"
            signNum = 4
        } else if( (dMonth == 07 && dDay >= 23) || (dMonth == 08 && dDay <= 22) ){
            sign = "Leo - The Lion"
            signNum = 5
        } else if( (dMonth == 08 && dDay >= 23) || (dMonth == 09 && dDay <= 22) ){
            sign = "Virgo - The Virgin"
            signNum = 6
        } else if( (dMonth == 09 && dDay >= 23) || (dMonth == 10 && dDay <= 22) ){
            sign = "Libra - The Scales"
            signNum = 7
        } else if( (dMonth == 10 && dDay >= 23) || (dMonth == 11 && dDay <= 21) ){
            sign = "Scorpio - The Scorpion"
            signNum = 8
        } else if( (dMonth == 11 && dDay >= 22) || (dMonth == 12 && dDay <= 21) ){
            sign = "Sagittarius - The Centaur"
            signNum = 9
        } else if( (dMonth == 12 && dDay >= 22) || (dMonth == 01 && dDay <= 19) ){
            sign = "Capricorn - The Goat"
            signNum = 10
        } else if( (dMonth == 01 && dDay >= 20) || (dMonth == 02 && dDay <= 18) ){
            sign = "Aquarius - The Water Bearer"
            signNum = 11
        } else if( (dMonth == 02 && dDay >= 19) || (dMonth == 03 && dDay <= 20) ){
            sign = "Pisces - The Fish"
            signNum = 12
        }
        
        signLabels[signNum-1].textColor = UIColor.blueColor()
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        signLabels = [aries, taurus, gemini, cancer, leo, virgo, libra, scorpio, sagittarius, capricorn, aquarius, pisces]
        setSign()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "showHoroscope"{
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
            var strDate = dateFormatter.stringFromDate(birthdate.date)
            
            (segue.destinationViewController as! SecondViewController).birthdayData = strDate
            (segue.destinationViewController as! SecondViewController).signData = sign
        }
    }


}

