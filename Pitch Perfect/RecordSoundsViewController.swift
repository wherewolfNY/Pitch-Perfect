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
    
        @IBAction func stopRecording(_ sender: UIButton) {
        recordButton.isEnabled = true
        stopButton.isEnabled = false
        taptoRecordLabel.text = "Press Button to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    @IBAction func startRecording(_ sender: AnyObject) {
        //        Establish file path name for recorded audio
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) [0]
        print (dirPath)
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.string(from: currentDateTime)+".wav"
        print (recordingName)
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        print(filePath)
        // Change button and lable views
        recordButton.isEnabled = false
        stopButton.isEnabled = true
        taptoRecordLabel.text = "Recording!"

        //        Initiate audio session
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch _ {
        }
        //        Record the audio
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            print ("audioRecorderDidFinishRecording")
            self.performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print ("Recorded file not saved")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let data = sender as! URL
            playSoundsVC.receivedAudioPath = data
        }
    }
 
    override func viewWillAppear(_ animated: Bool) {
        stopButton.isEnabled = false
        recordButton.isEnabled = true
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

