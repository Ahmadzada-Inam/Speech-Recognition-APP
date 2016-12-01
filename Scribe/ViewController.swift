//
//  ViewController.swift
//  Scribe
//
//  Created by Inam Ahmad-zada on 2016-11-30.
//  Copyright © 2016 Devslopes. All rights reserved.
//

import UIKit
import Speech
import AVKit

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true
    }
    
    func requestSpeechAuto(){
        
        SFSpeechRecognizer.requestAuthorization{ authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized{
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a"){
                    do{
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                    }catch{
                        print("Error")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request){ (result, error) in
                        if let error = error{
                            print("Error: \(error)")
                        }else{
                            print(result?.bestTranscription.formattedString as Any)
                        }
                    }
                }
            }
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
    }
    
    @IBAction func playBtnPressed(_ sender: UIButton) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuto()
    }

}

