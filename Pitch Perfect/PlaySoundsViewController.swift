//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jason Waldroup on 9/10/16.
//  Copyright © 2016 Jason Waldroup. All rights reserved.
//

import AVFoundation
import UIKit

class PlaySoundsViewController: UIViewController {    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    var receivedAudioPath : NSURL!
    var audioFile : AVAudioFile!
    var audioEngine : AVAudioEngine!
    var audioPlayerNode : AVAudioPlayerNode!
    var stopTimer:NSTimer!
    
    enum ButtonType: Int { case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb }
    
    
    @IBAction func playSoundForButton(sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        
        configureUI(.Playing)
    }
    
    @IBAction func stopButtonPressed(sender: AnyObject) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view
    }
    
    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
    }
}
    
//    var audioPlayer : AVAudioPlayer!

//    func stopAllAudio () {
//        audioPlayer.stop()
//        audioEngine.stop()
//        audioEngine.reset()
//        stopButton.enabled = false
//    }
//    func playAudio(speed : Float) {
//        stopAllAudio()
//        stopButton.enabled = true
//        audioPlayer.rate = speed
//        audioPlayer.currentTime = 0
//        audioPlayer.play()
//    }
//    @IBOutlet weak var stopButton: UIButton!
//    @IBAction func stopAudio(sender: UIButton) {
//        stopAllAudio()
//    }
//    @IBAction func playFastAudio(sender: UIButton) {
//        playAudio(1.5)
//    }
//    @IBAction func playSlowAudio(sender: UIButton) {
//        playAudio(0.5)}
//    @IBAction func playDarthVaderAudio(sender: UIButton) {
//        playAudioPitchEffect(-1000)
//    }
//    @IBAction func playChipmunkAudio(sender: UIButton) {
//        playAudioPitchEffect(1000)
//    }
//    func playAudioPitchEffect (pitch : Float) {
//        stopAllAudio()
//        stopButton.enabled = true
//        audioEngine = AVAudioEngine()
//        audioPlayerNode = AVAudioPlayerNode()
//        audioEngine.attachNode(audioPlayerNode)
//        
//        let changePitchEffect = AVAudioUnitTimePitch()
//        changePitchEffect.pitch = pitch
//        audioEngine.attachNode(changePitchEffect)
//        
//        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
//        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
//        
//        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
//        
//        //        do {
//        //            audioEngine.startAndReturnError()
//        //        } catch _ {
//        //  }
//        audioPlayerNode.play()
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        audioPlayer = try? AVAudioPlayer(contentsOfURL: receivedAudioPath)
////        audioPlayer.enableRate = true
////        audioEngine = AVAudioEngine()
//        audioFile = try? AVAudioFile(forReading: receivedAudioPath)
//        // Do any additional setup after loading the view.
//    }
//    override func viewWillAppear(animated: Bool) {
//        stopButton.enabled = false
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//}
