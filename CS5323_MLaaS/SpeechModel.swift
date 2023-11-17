//
//  GenderModel.swift
//  CS5323_MLaaS
//
//  Created by jason brown on 25/08/1402 AP.
//


import Foundation
import UIKit
import AVFoundation

class SpeechModel : NSObject, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var soundRecorder = AVAudioRecorder()
    var soundPlayer = AVAudioPlayer()
    var fileName = "audioFile.m4a"
    var vc = ModuleAViewController()
    var cflag: Bool
    
    
    override init(){
        self.cflag = false
        super.init()
        setupRecorder()
        
       

        
        
    }
    
    func setupRecorder() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
            try audioSession.setActive(true)
            
            let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let soundFilePath = documentPath.appendingPathComponent(fileName)
            
            let recordSettings: [String: Any] = [
                AVFormatIDKey: kAudioFormatAppleLossless,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
                AVEncoderBitRateKey: 320000,
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 2,
            ]
            
            soundRecorder = try AVAudioRecorder(url: soundFilePath, settings: recordSettings)
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
        } catch {
            print("Error setting up audio session or recorder: \(error.localizedDescription)")
        }
    }
    
    
    func recordSound() {
        
        if !soundRecorder.isRecording {
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                soundRecorder.record()
            } catch {
                print("Error starting recording: \(error.localizedDescription)")
            }
            
            
            cflag = true
            
        } else {
            
            soundRecorder.stop()
            
            cflag = false
            
        }
    }
    
    func playSound() {
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: soundRecorder.url)
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func postSound() {
        
    }
        
    
}

