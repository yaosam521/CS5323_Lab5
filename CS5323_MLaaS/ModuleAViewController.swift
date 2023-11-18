
import UIKit
import AVFoundation

class ModuleAViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    
    var soundRecorder = AVAudioRecorder()
    var soundPlayer = AVAudioPlayer()
    var fileName = "audioFile.wav"
    var speechModel:SpeechModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.speechModel = SpeechModel()
        speechModel?.setupRecorder()
        
    }
    
                                        
    
    @IBAction func recordSound(_ sender: Any) {
        
        if(speechModel?.cflag==false){
            speechModel?.recordSound()
            // Update UI for recording state
            self.recordButton?.setTitle("stop", for: .normal)
        }
        else{
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
