//
//  PlaySoundViewController.swift
//  PitchPerfect
//
//  Created by mohit kotie on 01/10/18.
//  Copyright © 2018 mohit kotie. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
     
     @IBOutlet weak var snailButton: UIButton!
     @IBOutlet weak var chipmunkButton: UIButton!
     @IBOutlet weak var rabbitButton: UIButton!
     @IBOutlet weak var vaderButton: UIButton!
     @IBOutlet weak var echoButton: UIButton!
     @IBOutlet weak var reverbButton: UIButton!
     @IBOutlet weak var stopButton: UIButton!
     
     var recordedAudioURL:URL!
     var audioFile:AVAudioFile!
     var audioEngine:AVAudioEngine!
     var audioPlayerNode: AVAudioPlayerNode!
     var stopTimer: Timer!
     
     enum ButtonType: Int {
          case slow = 0, fast, chipmunk, vader, echo, reverb
     }
     

    override func viewDidLoad() {
        super.viewDidLoad()
          setupAudio()
        // Do any additional setup after loading the view.
    }
     
     override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          configureUI(.notPlaying)
          
     }
     @IBAction func PlaySoundForButton(_ sender: Any) {
          switch(ButtonType(rawValue: (sender as AnyObject).tag)!) {
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
     
     @IBAction func stopButtonPressed(_ sender: Any) {
          stopAudio()
     }
     
     
     
    

    }
