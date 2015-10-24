//
//  SecondViewController.swift
//  kos_lab_8
//
//  Created by Brittany Kos on 10/23/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    //http://widgets.fabulously40.com/horoscope.json?sign=aries&date=2009-05-03
    
    @IBOutlet weak var birthdayLabel: UITextView!
    @IBOutlet weak var signLabel: UITextView!
    @IBOutlet weak var horoscopeLabel: UITextView!
    
    @IBOutlet weak var inActivity: UIActivityIndicatorView!
    
    
    var birthdayData: String? {
        didSet {
        }
    }
    var signData: String? {
        didSet {
        }
    }
    var horoscopeData: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        birthdayLabel.text = birthdayData
        signLabel.text = signData
        
        var signArray = signData!.componentsSeparatedByString(" ")
        var sign: String = signArray[0]
        sign = sign.lowercaseString
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        var date = dateFormatter.stringFromDate(NSDate())
        
        var urlStr = "http://widgets.fabulously40.com/horoscope.json?sign=" + sign + "&date=2013-" + date
        //println(urlStr);
        let url = NSURL(string: urlStr)
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url!, completionHandler: { (data: NSData!, response:NSURLResponse!, error: NSError!) -> Void in
            //println( NSString(data: data, encoding: NSUTF8StringEncoding) )
            
            if let responseJSON: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary {
                
                if let horo = responseJSON["horoscope"] as? NSDictionary{
                    //println(horo);
                    var h = horo["horoscope"] as! String
                    //println(h)
                    self.horoscopeData = h
                    //println("in json: " + self.horoscopeData)
                }
            }

        })
        dataTask.resume()
        
        
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 1))
        dispatch_after(delayTime, dispatch_get_main_queue()){
            //changeColourOfPage()
            //println("end view load: " + self.horoscopeData)
            self.horoscopeLabel.text = self.horoscopeData
            
            self.inActivity.removeFromSuperview()
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
