
import UIKit
import AVFoundation

class ModuleAViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    
    var soundRecorder = AVAudioRecorder()
    var soundPlayer = AVAudioPlayer()
    var fileName = "audioFile.m4a"
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
            
            self.recordButton?.setTitle("stop", for: .normal)
        }
        else{
            speechModel?.recordSound()
            self.recordButton?.setTitle("Record", for: .normal)
        }
       
    }
    
    @IBAction func playSound(_ sender: Any) {
        self.speechModel?.playSound()
    }
    
    @IBAction func postSound(_ sender: Any) {
        
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
