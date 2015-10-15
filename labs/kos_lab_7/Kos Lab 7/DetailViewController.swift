//
//  DetailViewController.swift
//  Kos Lab 7
//
//  Created by Brittany Kos on 10/15/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var stop: UIButton!
    
    var audioPlayer: AVAudioPlayer?
    var fileName = ""
    var audioFileURL = NSURL()

    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            /*
            if let detail: AnyObject = self.detailItem {
                if let label = self.detailDescriptionLabel {
                    label.text = detail.description
                }
            }
            */
            if let detail: AnyObject = self.detailItem {
                fileName = detail.description + ".caf"
            }
        }
    }
    
    @IBAction func playAudio(sender: UIButton) {
        println("in detail: playAudio");
        //if not recording play audio file
        stop.enabled = true
        var error: NSError?
        
        //create the AVAudioPlayer instance
        audioPlayer = AVAudioPlayer(contentsOfURL: audioFileURL, error: &error)
        
        //test for error
        if let err = error {
            println("AVAudioPlayer error: \(err.localizedDescription)")
        } else {
            audioPlayer?.delegate=self //sets the delegate
            audioPlayer?.play() //plays audio file
        }
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
        println("in detail: stopAudio");
        stop.enabled = false
        play.enabled = true
        
        audioPlayer?.stop()
    }
    
    //AVAudioPlayerDelegate method
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully
        flag: Bool) {
            stop.enabled = false
    }
    
    
    override func viewDidLoad() {
        stop.enabled = false
        
        //get path for the audio file
        let dirPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let docDir = dirPath[0] as! String //documents directory
        let audioFilePath = docDir.stringByAppendingPathComponent(fileName)
        audioFileURL = NSURL(fileURLWithPath: audioFilePath)! //URL to the audio file
        
        println("in detail: fileName: " + fileName);
        super.viewDidLoad()
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
