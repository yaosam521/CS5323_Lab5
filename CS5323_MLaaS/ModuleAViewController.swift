
import UIKit
import AVFoundation

class ModuleAViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    let gender = ["Male", "Female"]
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var genderPicker: UIPickerView!
    
    @IBOutlet weak var playLabel: UIButton!
    var soundRecorder = AVAudioRecorder()
    var soundPlayer = AVAudioPlayer()
    var fileName = "audioFile.wav"
    var speechModel:SpeechModel? = nil
    var genderSelection: Int = 0
    
    @IBAction func sceneSelector(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            genderPicker.isHidden = false
            recordButton.isHidden = false
            postButton.isHidden = false
            playLabel.isHidden = false
            
        case 1:
            genderPicker.isHidden = true
            recordButton.isHidden = true
            postButton.isHidden = true
            playLabel.isHidden = true
            
        default:
            break;
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.speechModel = SpeechModel()
        speechModel?.setupRecorder()
        genderPicker.dataSource = self
        genderPicker.delegate = self
        genderPicker.isHidden = false
        
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
        //Call play recording function
        self.speechModel?.playSound()
    }
    
    @IBAction func postSound(_ sender: Any) {
        //Call play post function
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



