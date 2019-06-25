//
//  recordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Sherif on 7/15/18.
//  Copyright © 2018 Sherif-Eldeeb. All rights reserved.
//

import UIKit
import AVFoundation
// MARK: recordSoundController: AVAudioDelegate
class recordSoundsViewController: UIViewController,AVAudioRecorderDelegate, UITextFieldDelegate {
    @IBOutlet weak var Record: UIButton!
    @IBOutlet weak var recordingState: UILabel!
    @IBOutlet weak var stopRecord: UIButton!
    @IBOutlet weak var FileName: UITextView!

    var file_Name: String!
    var audioRecord: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        FileName.text = file_Name+".wav"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopRecord.isEnabled = false
    }

    // MARK: Recording Functions
    @IBAction func startRecord(_ sender: AnyObject) {
        // MARK: apply the appropiate UI for Buttons
        configuringUI(isRecording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/" ))
        // MARK: Stablishment of the audio session
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
        // MARK: Joining the full file Path
        try! audioRecord = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecord.delegate = self
        audioRecord.isMeteringEnabled = true
        audioRecord.prepareToRecord()
        audioRecord.record()
    }
    
    @IBAction func stopRecording(_ sender: AnyObject) {
        recordingState.text = "Processing..."
        // MARK: making a one second delay to perform a processing behavior
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.configuringUI(isRecording: false)
            self.audioRecord.stop()
            let session = AVAudioSession.sharedInstance()
            try! session.setActive(false)
        }
    }
    // MARK: get when the file is finished and saved to perform the segue
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "recordingFinished", sender: audioRecord.url)
        }else{
            print("Record Can`t Be Saved")
        }
    }
    // MARK: transfer the audio address to the second controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recordingFinished"{
            let playBackVC = segue.destination as! playBackViewController
            let recordedAudioURL = sender as! URL
            playBackVC.fileName = file_Name
            playBackVC.recordedAudioURL = recordedAudioURL
        }
    }
    // MARK: Switching the UI for the audio modes and stop Buttons
    func configuringUI(isRecording: Bool){
        switch isRecording {
        case true:
            recordingState.text = "Recording..."
            stopRecord.isEnabled = true
            Record.isEnabled = false
        default:
            recordingState.text = "Tap To Record!"
            Record.isEnabled = true
            stopRecord.isEnabled = false
        }
    }
}
