//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation // Sound module

class ViewController: UIViewController {
    
    // Dictionary (uses key value pairs)
    let eggTimes: [String : Int] = ["Soft": 300, "Medium": 420, "Hard": 720]
    var secondsPassed = 0
    var totalTime = 0
    var timer = Timer()
    // Create an instance of the audio object
    var player = AVAudioPlayer()

    @IBOutlet weak var doneTitle: UILabel!
    @IBOutlet weak var eggProgress: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        UIApplication.shared.isIdleTimerDisabled = true // disables sleep mode
        timer.invalidate() // stops the timer
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        doneTitle.text = hardness
        player.stop() // Stops the alarm if the user clicks the button consecutably
        
        // Resets things back to zero
        eggProgress.progress = 0.0
        secondsPassed = 0
                
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsPassed < self.totalTime {
                
                self.secondsPassed += 1
                let percentageProgress: Float = Float(self.secondsPassed) / Float(self.totalTime)
                self.eggProgress.progress = Float(percentageProgress)
                
            } else {
                // Stops the timer
                Timer.invalidate()
                self.doneTitle.text = "Done"
                self.playSound()
                UIApplication.shared.isIdleTimerDisabled = false
//                UIImpactFeedbackGenerator(style: .heavy).impactOccurred() // Makes the phone vibrate
                
            }
        }
        
    }
    
    func playSound() {
        // Gets a refrence to the audio file
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
    
}
