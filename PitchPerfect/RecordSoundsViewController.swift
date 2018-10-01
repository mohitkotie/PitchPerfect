//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by mohit kotie on 26/09/18.
//  Copyright © 2018 mohit kotie. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate{
     
     var audioRecorder: AVAudioRecorder!
     
     @IBOutlet weak var recordingLabel: UILabel!
     @IBOutlet weak var recordButton: UIButton!
     @IBOutlet weak var stopRecordingButton: UIButton!
     
     override func viewDidLoad() {
          super.viewDidLoad()
          // Do any additional setup after loading the view, typically from a nib.
          stopRecordingButton.isEnabled = false
          
     }
     

     @IBAction func recordAudio(_ sender: Any) {
          recordingLabel.text = "Recording in Progress.."
          stopRecordingButton.isEnabled = true
          recordButton.isEnabled = false
          
//          let dirpath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
          let dirpath = try! FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
          let recordingName = "recordedVoice.m4a"
//          let pathArray = [dirpath,recordingName]
          let settings = [
               AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
               AVSampleRateKey: 12000,
               AVNumberOfChannelsKey: 1,
               AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
          ]
          let filePath = dirpath.appendingPathComponent(recordingName)
          let session = AVAudioSession.sharedInstance()
          try! session.setActive(true)
          try! session.setCategory(AVAudioSession.Category.playAndRecord,  mode: .default , options: [])
          try! audioRecorder =  AVAudioRecorder(url: filePath, settings: settings)
     

          audioRecorder.delegate = self
          audioRecorder.isMeteringEnabled = true
          audioRecorder.prepareToRecord()
          audioRecorder.record()
          
     }
     
     
     @IBAction func stopRecording(_ sender: Any) {
          recordButton.isEnabled = true
          stopRecordingButton.isEnabled = false
          recordingLabel.text = "Tap to Record"
          audioRecorder.stop()
          let audiosession = AVAudioSession.sharedInstance()
          try! audiosession.setActive(false)

     }
     
     
     func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
          if flag{
               performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
          }else{
               print("recording was not successful")
          }
     }
     
}

