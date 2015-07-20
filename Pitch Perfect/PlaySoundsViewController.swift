//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Andrew Liu on 7/18/15.
//  Copyright (c) 2015 Andrew Liu. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var receivedAudio: RecordedAudio!
    
    var audioPlayer: AVAudioPlayer!
    
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!

    // MARK:
    // MARK: app life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathURL, error: nil)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Play"
    }
    
    // MARK:
    
    @IBAction func playSlowAudio(sender: UIButton) {
        palyAudioWithRate(0.5)
    }

    @IBAction func playFastAudio(sender: UIButton) {
        palyAudioWithRate(1.5)
    }

    @IBAction func playChipmunkAudio(sender: UIButton) {
        palyAudioWithPitch(1200.0)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        palyAudioWithPitch(-1200.0)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        stopAll()
    }
    
    // MARK:
    // MARK: helper mthod
    
    func stopAll(){
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func palyAudioWithRate(rate: Float) {
        stopAll()
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func palyAudioWithPitch(pitch: Float) {
        stopAll()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
}
