//
//  DeveloperController.swift
//  SpaceCamp
//
//  Created by Ehsan on 17/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit
import AVFoundation

class DeveloperController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var techLabel: UILabel!
    
    var player: AVAudioPlayer?
    
    var timer = Timer()
    
    // closure dedicated to myself(Developer)
    // typealias ImageFunction = () -> UIImage
    // func myNextImage() -> ImageFunction
    let aliNextImage = StaticImages.myNextImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "About Developer"

        guard let path = Bundle.main.path(forResource: "PianoIntro", ofType: "mp3") else {
            return
        }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.setVolume(0.8, fadeDuration: 0)
            player?.play()
        } catch {
            print("could not load file")
        }
        
        
        
        //playSound(track: StaticProperties.developerSoundName, id: &StaticProperties.developerSoundID)
        
        imageView.center.x = self.view.frame.width + self.view.frame.width
        titleLabel.center.x = self.view.frame.width + self.view.frame.width
        techLabel.center.x = self.view.frame.width  + self.view.frame.width
        
        UIView.animate(withDuration: 5.0, delay: 0.2, usingSpringWithDamping: 4.0, initialSpringVelocity: 5, options: .curveLinear, animations: {
            self.imageView.center.x = self.view.frame.width / 2
        }, completion: nil)
        
        UIView.animate(withDuration: 4.0, delay: 1.2, usingSpringWithDamping: 4.0, initialSpringVelocity: 7, options: .curveLinear, animations: {
            self.titleLabel.center.x = self.view.frame.width / 2
        }, completion: nil)
        
        UIView.animate(withDuration: 3.0, delay: 2.2, usingSpringWithDamping: 1.0, initialSpringVelocity: 3, options: .curveLinear, animations: {
            self.techLabel.center.x = self.view.frame.width / 2
        }, completion: nil)
        
    }
    
    
    @objc func changeImage() {
        UIView.transition(with: imageView, duration: 0.6, options: .transitionFlipFromLeft, animations: {
            self.imageView.image = self.aliNextImage()
        }, completion: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        // validating timer coming back to this view
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
    }
    
    
}
