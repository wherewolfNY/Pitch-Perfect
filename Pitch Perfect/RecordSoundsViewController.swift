//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jason Waldroup on 9/10/16.
//  Copyright © 2016 Jason Waldroup. All rights reserved.
//

import AVFoundation
import UIKit

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate{
    var audioRecorder:AVAudioRecorder!
    var recordingPaused = false
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var taptoRecordLabel: UILabel!
    
        @IBAction func stopRecording(sender: UIButton) {
        recordButton.enabled = true
        stopButton.enabled = false
        taptoRecordLabel.text = "Press Button to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    @IBAction func startRecording(sender: AnyObject) {
        //        Establish file path name for recorded audio
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) [0]
        print (dirPath)
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        print (recordingName)
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        // Change button and lable views
        recordButton.enabled = false
        stopButton.enabled = true
        taptoRecordLabel.text = "Recording!"

        //        Initiate audio session
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch _ {
        }
        //        Record the audio
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            print ("audioRecorderDidFinishRecording")
            self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        } else {
            print ("Recorded file not saved")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! NSURL
            playSoundsVC.receivedAudioPath = data
        }
    }
 
    override func viewWillAppear(animated: Bool) {
        stopButton.enabled = false
        recordButton.enabled = true
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

//@IBAction func pauseRecording(sender: UIButton) {
//    if recordingPaused {
//        audioRecorder.record()
//        recordingPaused = false
//        pausedLabel.hidden = true
//    } else {
//        audioRecorder.pause()
//        recordingPaused = true
//        pausedLabel.hidden = false
//    }
//}
