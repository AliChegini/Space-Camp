//
//  Extensions.swift
//  SpaceCamp
//
//  Created by Ehsan on 14/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

extension UIViewController {
    // function to convert String to Date
    // it takes an String -> Date?
    func convertStringToDate(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: string) else {
            return nil
        }
        return date
    }
    
    // function to convert Date to String
    // it takes an Date -> String
    func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let string = dateFormatter.string(from: date)
        
        return string
    }
    
}

// helper to play sounds
extension UIViewController {
    func playSound(track name: String, with player: inout AVAudioPlayer, volume: Float) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("Could not find soundtrack")
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.setVolume(volume, fadeDuration: 0)
            player.play()
        } catch {
            print("could not load file")
        }
    }
}




// helper to play sounds
extension UIViewController {
    func loadSound(track name: String, id: inout SystemSoundID ) {
        if let stringFileURL = Bundle.main.path(forResource: name, ofType: "mp3") {
            let url = URL(fileURLWithPath: stringFileURL)
            AudioServicesCreateSystemSoundID(url as CFURL, &id)
        } else {
            print("failed to play sound")
        }
    }
    
    func playSound(track name: String, id: inout SystemSoundID) {
        loadSound(track: name, id: &id)
        AudioServicesPlaySystemSound(id)
    }
}


// extension to alert the user for connection related errors from JSONDownloader
extension UIAlertController {
    func presentInOwnWindow(animated: Bool, completion: (() -> Void)?) {
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else { return }
        rootVC.present(self, animated: animated, completion: completion)
    }
}


extension UIButton {
    func roundButton() {
        self.layer.cornerRadius = 10
    }
}

