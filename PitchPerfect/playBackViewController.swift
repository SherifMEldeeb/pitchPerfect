//
//  playBackViewController.swift
//  PitchPerfect
//
//  Created by Sherif on 7/16/18.
//  Copyright © 2018 Sherif-Eldeeb. All rights reserved.
//

import UIKit
import AVFoundation

class playBackViewController: UIViewController {
    @IBOutlet weak var file_Name: UITextView!
    @IBOutlet weak var slow: UIButton!
    @IBOutlet weak var fast: UIButton!
    @IBOutlet weak var highPitch: UIButton!
    @IBOutlet weak var lowPitch: UIButton!
    @IBOutlet weak var Echo: UIButton!
    @IBOutlet weak var Reverb: UIButton!
    @IBOutlet weak var Stop: UIButton!
    
    var fileName : String!
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        file_Name.text = fileName+".wav"
        setupAudio()
        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
        let startAgainBack = UIBarButtonItem(title: "StartOver", style: .plain, target: self , action: #selector( Back(_:) ))
        navigationItem.leftBarButtonItem = startAgainBack
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
            switch(ButtonType(rawValue: sender.tag)!) {
            case .slow:
                playSound(rate: 0.5)
            case .fast:
                playSound(rate: 1.5)
            case .chipmunk:
                playSound(pitch: 1000)
            case .vader:
                playSound(pitch: -1000)
            case .echo:
                playSound(echo: true)
            case .reverb:
                playSound(reverb: true)
            }
            
            configureUI(.playing)
        }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
            stopAudio()
    }
    
    @objc func Back(_ : UIBarButtonItem) {
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[0])!, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
