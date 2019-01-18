//
//  MainViewController.swift
//  SpaceCamp
//
//  Created by Ehsan on 04/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//


// API Key : auLEKaiKVBCr8tO6ZIrWDfBFnj6NQWFrEjrQyQN0

import UIKit
import Foundation
//import AudioToolbox
import AVFoundation

class MainViewController: UIViewController {

    @IBOutlet weak var apodButton: UIButton!
    @IBOutlet weak var marsRoverButton: UIButton!
    
    let parser = JSONParser()
    
    // will be used to send via segue to ApodController
    let cachedApodObject = NSCache<AnyObject, AnyObject>()
    var timer = Timer()
    
    
    var sound: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        
        
        let path = Bundle.main.path(forResource: "AppLaunch", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        
        do {
            sound = try AVAudioPlayer(contentsOf: url)
            sound?.setVolume(0.1, fadeDuration: 0)
            sound?.play()
        } catch {
            print("could not load file")
        }
        
        
        
        
        
        //playSound(track: StaticProperties.appLaunchSoundName, id: &StaticProperties.appLaunchSoundID)
        
        // Disableing apod button until API respond
        apodButton.isEnabled = false
        // set a random image for rover button to start with
        marsRoverButton.setBackgroundImage(StaticImages.generateRandomImage(), for: .normal)
        
        // parse APOD object if API is responding
        parser.parseApod { (apod, error) in
            guard let apod = apod else {
                print("apod is nil")
                return
            }
            
            if let url = apod.url, let explanation = apod.explanation, let title = apod.title, let hdUrl = apod.hdurl {
                // by having a url, we can retrieve image to show
                self.parser.client.getData(from: url) { (data, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            // change apodButton background image with nice animation
                            UIView.transition(with: self.apodButton, duration: 2.0, options: .transitionCurlUp, animations: {
                                self.apodButton.setBackgroundImage(UIImage(data: data), for: .normal)
                            }, completion: nil)
                            // since API health is ok enable the button
                            self.apodButton.isEnabled = true
                        }
                        guard let imageToCache = UIImage(data: data) else {
                            return
                        }
                        
                        let apodObjectToCache = CacheApodObject(image: imageToCache, title: title, explanation: explanation, hdUrl: hdUrl)
                        self.cachedApodObject.setObject(apodObjectToCache as AnyObject, forKey: "APOD" as AnyObject)
                        
                    }
                }
            }
        }
        
        
//        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
        
    }

    
    @objc func changeImage() {
        UIView.transition(with: marsRoverButton, duration: 1.0, options: .transitionFlipFromBottom, animations: {
            self.marsRoverButton.setBackgroundImage(StaticImages.generateRandomImage(), for: .normal)
        }, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // invalidate timer when leaving the view
        timer.invalidate()
        
        if segue.identifier == "apodSegue" {
            if let apodController = segue.destination as? ApodController {
                if let cachedObject = cachedApodObject.object(forKey: "APOD" as AnyObject) as? CacheApodObject {
                    apodController.apod = cachedObject
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // validating timer coming back to this view
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
    }
    
    
    
}
