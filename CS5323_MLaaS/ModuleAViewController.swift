//
//  ModuleAViewController.swift
//  CS5323_MLaaS
//
//  Created by Sam Yao on 11/7/23.
//

import UIKit
import AVFoundation

class ModuleAViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    
    var soundRecorder = AVAudioRecorder()
    var soundPlayer = AVAudioPlayer()
    var fileName = "audioFile.m4a"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupRecorder()
    }
    
    func setupRecorder() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            // Set up the audio session for play and record
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
            try audioSession.setActive(true)
            
            // Set up file path for recording
            let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let soundFilePath = documentPath.appendingPathComponent(fileName)
            
            // Define recording settings
            let recordSettings: [String: Any] = [
                AVFormatIDKey: kAudioFormatAppleLossless,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
                AVEncoderBitRateKey: 320000,
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 2,
            ]
            
            // Create and configure AVAudioRecorder
            soundRecorder = try AVAudioRecorder(url: soundFilePath, settings: recordSettings)
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
        } catch {
            print("Error setting up audio session or recorder: \(error.localizedDescription)")
        }
    }
                                        
    
    @IBAction func recordSound(_ sender: Any) {
        if !soundRecorder.isRecording {
            do {
                // Activate audio session and start recording
                try AVAudioSession.sharedInstance().setActive(true)
                soundRecorder.record()
            } catch {
                print("Error starting recording: \(error.localizedDescription)")
            }
            // Update UI for recording state
            recordButton.setTitle("stop", for: .normal)
        } else {
            // Stop recording if already recording
            soundRecorder.stop()
            // Update UI for non-recording state
            recordButton.setTitle("record", for: .normal)
        }
    }
    
    @IBAction func playSound(_ sender: Any) {
        do {
            // Create and configure AVAudioPlayer for playback
            soundPlayer = try AVAudioPlayer(contentsOf: soundRecorder.url)
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    @IBAction func postSound(_ sender: Any) {
        
        // Get the file path to upload
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let soundFilePath = documentPath.appendingPathComponent(fileName)
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
