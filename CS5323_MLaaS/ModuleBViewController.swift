//
//  ModuleBViewController.swift
//  CS5323_MLaaS
//
//  Created by Sam Yao on 11/7/23.
//

import UIKit
import AVFoundation

class ModuleBViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    //Create Speech Model
    var speechModel: SpeechModel? = nil
    var soundRecorder = AVAudioRecorder()
    var soundPlayer = AVAudioPlayer()

    //Segment
    @IBOutlet weak var trainTestSegment: UISegmentedControl!
    
    //Buttons
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    //Pickers
    @IBOutlet weak var genderPicker: UIPickerView!
    @IBOutlet weak var modelPicker: UIPickerView!
    
    //Gender Picker Selections
    let genders = ["male","female"]
    let models = ["Neural Net", "Logiustic Regression"]
    
    //Storing picker selections
    var genderSelection: Int = 0
    var modelSElection: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.speechModel = SpeechModel()
        speechModel?.setupRecorder()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recordSound(_ sender: Any) {
        if(speechModel?.cflag==false){
            
            // Update UI for recording state
            self.recordButton?.setTitle("stop", for: .normal)
            //genderPicker.isHidden = true
            self.genderSelection = genderPicker.selectedRow(inComponent: 0)
            print(self.genderSelection)
            speechModel?.recordSound()
        }
        else{
            //genderPicker.isHidden = false
            speechModel?.recordSound()
            // Update UI for non-recording state
            self.recordButton?.setTitle("Record", for: .normal)
        }
    }
    
    @IBAction func playSound(_ sender: Any) {
        self.speechModel?.playSound()
    }
    
    @IBAction func postSound(_ sender: Any) {
        speechModel?.postSound()
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
