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
        if segue.identifier == "manifestSegue" {
            if let manifestController = segue.destination as? ManifestController {
                if let roverName = roverName {
                    manifestController.roverName = roverName
                }
            }
        }
    }
    
    
    @IBAction func curiosity(_ sender: UIButton) {
        
        // play sound
        guard let path = Bundle.main.path(forResource: StaticProperties.curiosityRoverSound, ofType: "mp3") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.setVolume(0.4, fadeDuration: 0)
            player?.play()
        } catch {
            print("could not play sound")
        }
        
        roverName = Rovers.Curiosity.rawValue.lowercased()
        performSegue(withIdentifier: "manifestSegue", sender: self)
    }
    
    @IBAction func opportunity(_ sender: UIButton) {
        
        // play sound
        guard let path = Bundle.main.path(forResource: StaticProperties.opportunityRoverSound, ofType: "mp3") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.setVolume(0.2, fadeDuration: 0)
            player?.play()
        } catch {
            print("could not play sound")
        }
        
        roverName = Rovers.Opportunity.rawValue.lowercased()
        performSegue(withIdentifier: "manifestSegue", sender: self)
    }
    
    @IBAction func Spirit(_ sender: UIButton) {
        
        // play sound
        guard let path = Bundle.main.path(forResource: StaticProperties.spiritRoverSound, ofType: "mp3") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.setVolume(0.1, fadeDuration: 0)
            player?.play()
        } catch {
            print("could not play sound")
        }
        
        roverName = Rovers.Spirit.rawValue.lowercased()
        performSegue(withIdentifier: "manifestSegue", sender: self)
    }
    

}

