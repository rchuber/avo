//
//  MessagesViewController.swift
//  avo
//
//  Created by Helen Li, Ryan Huber, and Tiffany Wang on 5/11/16.
//
//  This controller provides the recording functionality.
//  It the recording is sent using Socket.IO to a local server
//  for the purposes of demonstrating how the audio would play
//  to an advisor.
//  

import AVFoundation
import UIKit
import CoreData


class RecordMessageViewController: UIViewController, AVAudioRecorderDelegate {
    
    let socket = SocketIOClient(socketURL: NSURL(string:"http://localhost:3000")!)
    var name: String?
    var resetAck: SocketAckEmitter?
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var bigMicrophone: UIImageView!
    
    var recordingSession: AVAudioSession!
    var messageRecorder: AVAudioRecorder!
    var messagePlayer: AVAudioPlayer!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Socket.IO
        socket.connect()
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] (allowed: Bool) -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        // TBD: Implement recording failure message
                    }
                }
            }
        } catch {
            // TBD: Implement recording failure message
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadRecordingUI() {
        recordButton.addTarget(self, action: #selector(recordTapped), forControlEvents: .TouchUpInside)
        
        playButton.enabled = false
        playButton.alpha = 0.5
        playButton.addTarget(self, action: #selector(playTapped), forControlEvents: .TouchUpInside)
        
        sendButton.enabled = false
        sendButton.alpha = 0.5
        sendButton.addTarget(self, action: #selector(sendTapped), forControlEvents: .TouchUpInside)
    }
    
    
    class func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    class func getMessageURL() -> NSURL {
        let audioFilename = getDocumentsDirectory().stringByAppendingPathComponent("message.m4a")
        let audioURL = NSURL(fileURLWithPath: audioFilename)
        
        return audioURL
    }
    
    func startRecording() {

        // swap record with a stop button
        recordButton.setImage(UIImage(named: "stop-button"), forState: UIControlState.Normal)
        bigMicrophone.image = UIImage(named: "big-microphone-recording")

        
        let audioURL = RecordMessageViewController.getMessageURL()
        print(audioURL.absoluteString)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
        ]
        
        do {
            messageRecorder = try AVAudioRecorder(URL: audioURL, settings: settings)
            messageRecorder.delegate = self
            messageRecorder.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success success: Bool) {

        recordButton.setImage(UIImage(named: "record-button"), forState: UIControlState.Normal)
        bigMicrophone.image = UIImage(named: "big-microphone")
        
        messageRecorder.stop()
        messageRecorder = nil
        
        if success {
            
            if !playButton.enabled {
                UIView.animateWithDuration(0.35) { [unowned self] in
                    self.playButton.enabled = true
                    self.playButton.alpha = 1
                }
            }
            if !sendButton.enabled {
                UIView.animateWithDuration(0.35) { [unowned self] in
                    self.sendButton.enabled = true
                    self.sendButton.alpha = 1
                }
            }
            
        } else {
            
            let ac = UIAlertController(title: "Record failed", message: "There was a problem recording your message; please try again.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    func recordTapped() {
        if messageRecorder == nil {
            startRecording()
            
            if playButton.enabled {
                UIView.animateWithDuration(0.35) { [unowned self] in
                    self.playButton.enabled = false
                    self.playButton.alpha = 0.5
                }
            }
            if sendButton.enabled {
                UIView.animateWithDuration(0.35) { [unowned self] in
                    self.sendButton.enabled = false
                    self.sendButton.alpha = 0.5
                }
            }
        } else {
            finishRecording(success: true)
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    func playTapped() {
        let audioURL = RecordMessageViewController.getMessageURL()
        
        do {
            messagePlayer = try AVAudioPlayer(contentsOfURL: audioURL)
            messagePlayer.play()
        } catch {
            let ac = UIAlertController(title: "Playback failed", message: "There was a problem playing your whistle; please try re-recording.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    
    func sendTapped() {
        let audioURL = RecordMessageViewController.getMessageURL()
        let audioData = NSData(contentsOfURL: audioURL)
        let myBase64Data = audioData!.base64EncodedDataWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        let myBase64DataString = NSString(data: myBase64Data, encoding: NSUTF8StringEncoding)!
        
        socket.emit("recording", myBase64DataString)
        
        if playButton.enabled {
            UIView.animateWithDuration(0.35) { [unowned self] in
                self.playButton.enabled = false
                self.playButton.alpha = 0.5
            }
        }
        if sendButton.enabled {
            UIView.animateWithDuration(0.35) { [unowned self] in
                self.sendButton.enabled = false
                self.sendButton.alpha = 0.5
            }
        }
        
        
    }
    
}