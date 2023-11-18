//
//  GenderModel.swift
//  CS5323_MLaaS
//
//  Created by jason brown on 25/08/1402 AP.
//


import Foundation
import UIKit
import AVFoundation
import SwiftUI

class SpeechModel : NSObject, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var soundRecorder = AVAudioRecorder()
    var soundPlayer = AVAudioPlayer()
    var fileName = "audioFile.m4a"
    var vc = ModuleAViewController()
    var cflag: Bool
    
    enum Gender: String, CaseIterable, Identifiable{
        case male, female
        var id: Self { self }
    }
    @State private var selectedGender: Gender = .female
    //func Picker("Gender", selection: $selectedGender){
      //  ForEach(Gender.allCases) { gender in
        //    Text(gender.rawValue.capitalized)
        //}
    //}
    
    override init(){
        self.cflag = false
        super.init()
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
    
    
    func recordSound() {
        
        if !soundRecorder.isRecording {
            do {
                // Activate audio session and start recording
                try AVAudioSession.sharedInstance().setActive(true)
                soundRecorder.record()
            } catch {
                print("Error starting recording: \(error.localizedDescription)")
            }
            
            
            cflag = true
            
        } else {
            // Stop recording if already recording
            soundRecorder.stop()
            
            cflag = false
            
        }
    }
    
    func playSound() {
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
    
    func postSound() {
        // Get the file path to upload
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let soundFilePath = documentPath.appendingPathComponent(fileName)
        
        let apiUrl = URL(string: "https://example.com/upload")
        let session = URLSession.shared

        // Prepare the URLRequest
        var request = URLRequest(url: apiUrl!)
        request.httpMethod = "POST"

        // Create the upload task
        let task = session.uploadTask(with: request, fromFile: soundFilePath) { (data, response, error) in
            if let error = error {
                print("Error uploading file: \(error)")
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status code: \(httpResponse.statusCode)")

                    if let responseData = data {
                        // Process the response data if needed
                        do {
                            let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                            print("Response JSON: \(json)")
                        } catch {
                            print("Error parsing JSON response: \(error)")
                        }
                    }
                }
            }
        }
        
        task.resume() //start task
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

