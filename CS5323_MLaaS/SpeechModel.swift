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

class SpeechModel : NSObject, AVAudioPlayerDelegate, AVAudioRecorderDelegate, URLSessionDelegate {
    
    //MARK: CHANGE THIS EVERY TIME
    let BASE_URL = "http://10.9.155.194:8000"
    
    lazy var session: URLSession = {
        let sessionConfig = URLSessionConfiguration.ephemeral
        
        sessionConfig.timeoutIntervalForRequest = 5.0
        sessionConfig.timeoutIntervalForResource = 8.0
        sessionConfig.httpMaximumConnectionsPerHost = 1
        
        return URLSession(configuration: sessionConfig,
            delegate: self,
            delegateQueue:self.operationQueue)
    }()
    
    let operationQueue = OperationQueue()
    
    //var ringBuffer = RingBuffer()
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
    func postSound2() {
        // Get the file path to upload
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
        let baseURL = "\(SERVER_URL)/AddDataPoint"
        let postUrl = URL(string: "\(baseURL)")
        
        // create a custom HTTP POST request
        var request = URLRequest(url: postUrl!)
        
        // data to send in body of post request (send arguments as json)
        let jsonUpload:NSDictionary = ["feature":array,
                                       "label":"\(label)",
                                       "dsid":self.dsid]
        
        
        let requestBody:Data? = self.convertDictionaryToData(with:jsonUpload)
        
        request.httpMethod = "POST"
        request.httpBody = requestBody
        
        let postTask : URLSessionDataTask = self.session.dataTask(with: request,
            completionHandler:{(data, response, error) in
                if(error != nil){
                    if let res = response{
                        print("Response:\n",res)
                    }
                }
                else{
                    let jsonDictionary = self.convertDataToDictionary(with: data)
                    
                    print(jsonDictionary["feature"]!)
                    print(jsonDictionary["label"]!)
                }

        })
        
        postTask.resume() // start the task
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

