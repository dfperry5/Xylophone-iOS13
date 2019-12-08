//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func playSound(note: String){
        guard let sound = Bundle.main.url(forResource: "\(note)", withExtension: "wav") else {
           print("No Valid Sound for Note")
           return
       }
       do {
           try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
           try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: sound, fileTypeHint: AVFileType.wav.rawValue)
        
           guard let player = player else { return }
           player.play()
       } catch let error {
           print("Error trying to play sound: \(error.localizedDescription)")
       }
    }

    
    @IBAction func keyPressed(_ sender: UIButton) {
        sender.alpha = 0.5
        guard let soundNote = sender.currentTitle else {
            print("invalid button - it didn't have a title.")
            return
        }
        self.playSound(note: soundNote)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            sender.alpha = 1
        }

    }
        

}

