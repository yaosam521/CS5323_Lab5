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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
