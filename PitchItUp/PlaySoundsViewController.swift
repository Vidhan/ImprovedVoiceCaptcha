//
//  PlaySoundsViewController.swift
//  PitchItUp
//
//  Created by Vidhan Agarwal on 3/10/15.
//  Copyright (c) 2015 Vidhan Agarwal. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
//            var filePathUrl = NSURL.fileURLWithPath(filePath);
//            audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
//            audioPlayer.enableRate=true;
//            
//        }
//        else{
//            println("The filePath is empty")       }
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate=true;
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        let synth = AVSpeechSynthesizer()
        var myUtterance = AVSpeechUtterance(string: "This is a sample text")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlow(sender: UIButton) {
        audioPlayer.stop();
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime=0.0;
        audioPlayer.rate = 0.5;
        audioPlayer.play();
    }

   
    @IBAction func playFast(sender: UIButton) {
        audioPlayer.stop();
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime=0.0;
        audioPlayer.rate = 1.5;
        audioPlayer.play();
    }
    
    @IBAction func stopAudio(sender: UIButton) {
         audioPlayer.stop();
        audioEngine.stop()
        audioEngine.reset()
    }
   
    
    @IBAction func playHighPitch(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    @IBAction func playDarthVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch=pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    
    /*
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
