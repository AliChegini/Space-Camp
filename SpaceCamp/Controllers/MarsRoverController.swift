//
//  MarsRoverController.swift
//  SpaceCamp
//
//  Created by Ehsan on 07/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit
import AVFoundation

class MarsRoverController: UIViewController {

    var roverName: String?
    var player: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // play sound
        guard let path = Bundle.main.path(forResource: "ChangeRover", ofType: "mp3") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.setVolume(0.5, fadeDuration: 0)
            player?.play()
        } catch {
            print("could not load file")
        }
        
        if segue.identifier == "manifestSegue" {
            if let manifestController = segue.destination as? ManifestController {
                if let roverName = roverName {
                    manifestController.roverName = roverName
                }
            }
        }
    }
    
    
    @IBAction func curiosity(_ sender: UIButton) {
        roverName = Rovers.Curiosity.rawValue.lowercased()
        performSegue(withIdentifier: "manifestSegue", sender: self)
    }
    
    @IBAction func opportunity(_ sender: UIButton) {
        roverName = Rovers.Opportunity.rawValue.lowercased()
        performSegue(withIdentifier: "manifestSegue", sender: self)
    }
    
    @IBAction func Spirit(_ sender: UIButton) {
        roverName = Rovers.Spirit.rawValue.lowercased()
        performSegue(withIdentifier: "manifestSegue", sender: self)
    }
    

}

