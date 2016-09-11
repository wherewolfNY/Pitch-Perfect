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
    var recordedAudio:RecordedAudio!
    var recordingPaused = false
    
    @IBOutlet weak var taptoRecordLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingLabelOutlet: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var pausedLabel: UILabel!
    
    @IBAction func pauseRecording(sender: UIButton) {
        if recordingPaused {
            audioRecorder.record()
            recordingPaused = false
            pausedLabel.hidden = true
        } else {
            audioRecorder.pause()
            recordingPaused = true
            pausedLabel.hidden = false
        }
    }
    @IBAction func stopRecording(sender: UIButton) {
        recordButton.enabled = true
        recordingLabelOutlet.hidden = true
        stopButton.enabled = false
        taptoRecordLabel.hidden = false
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    @IBAction func startRecording(sender: UIButton) {
        //        Establish file path name for recorded audio
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) [0]
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        // Change button and lable views
        recordButton.enabled = false
        recordingLabelOutlet.hidden = false
        stopButton.enabled = true
        taptoRecordLabel.hidden = true
        pauseButton.hidden = false
        pauseButton.enabled = true
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
            // Save recorded audio
            recordedAudio = RecordedAudio(filePathUrl: recorder.url , title: recorder.url.lastPathComponent!)
            //Perform segue to PlaySoundsViewController
        }
        self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    override func viewWillAppear(animated: Bool) {
        stopButton.enabled = false
        recordButton.enabled = true
 //       taptoRecordLabel.hidden = false
 //       pauseButton.enabled = false
 //       recordingPaused = false
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

