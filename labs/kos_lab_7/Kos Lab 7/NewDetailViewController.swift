//
//  DetailViewController.swift
//  Kos Lab 7
//
//  Created by Brittany Kos on 10/15/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import UIKit
import AVFoundation

class NewDetailViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    @IBOutlet weak var record: UIButton!
    @IBOutlet weak var stop: UIButton!
    @IBOutlet weak var play: UIButton!
    
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    var fileName = ""
    var audioFileURL = NSURL()

    
    var detailItem: AnyObject? {
        didSet {
            if let detail: AnyObject = self.detailItem {
                fileName = detail.description + ".caf"
            }
        }
    }
    
    
    @IBAction func recordAudio(sender: UIButton) {
        println("in new: recordAudio");
        //if not already recording, start recording
        if audioRecorder?.recording == false{
            play.enabled = false
            stop.enabled = true
            audioRecorder?.record()
        }
    }
    
    @IBAction func playAudio(sender: UIButton) {
        println("in new: playAudio");
        //if not recording play audio file
        if audioRecorder?.recording == false{
            stop.enabled = true
            record.enabled = false
            var error: NSError?
            
            //create the AVAudioPlayer instance
            //audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder?.url, error: &error)
            audioPlayer = AVAudioPlayer(contentsOfURL: audioFileURL, error: &error)
            
            //test for error
            if let err = error {
                println("AVAudioPlayer error: \(err.localizedDescription)")
            } else {
                audioPlayer?.delegate = self //sets the delegate
                audioPlayer?.play() //plays audio file
            }
        }
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        println("in new: stopAudio");
        stop.enabled = false
        play.enabled = true
        record.enabled = true
        
        //stop recording or playing
        if audioRecorder?.recording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
        }
    }
    
    //AVAudioPlayerDelegate method
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
            record.enabled = true
            stop.enabled = false
    }
    
    override func viewDidLoad() {
        stop.enabled = false
        
        //get path for the audio file
        let dirPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let docDir = dirPath[0] as! String //documents directory
        let audioFilePath = docDir.stringByAppendingPathComponent(fileName)
        audioFileURL = NSURL(fileURLWithPath: audioFilePath)! //URL to the audio file
        
        //recorder settings
        //NSDictionary for settings
        let recordSettings = [AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue, AVEncoderBitRateKey: 16, AVNumberOfChannelsKey: 2, AVSampleRateKey: 44100.0]
        var error : NSError?
        
        //create the AVAudioRecorder instance
        audioRecorder = AVAudioRecorder(URL: audioFileURL, settings: recordSettings as [NSObject : AnyObject], error: &error)
        
        //test for error
        if let err = error {
            println("AVAudioRecorder error: \(err.localizedDescription)")
        } else { //no error
            audioRecorder?.delegate = self //sets the delegate
            audioRecorder?.prepareToRecord() //ready to record
        }
        
        println("in new: fileName: " + fileName);
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

