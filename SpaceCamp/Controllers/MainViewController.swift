//
//  MainViewController.swift
//  SpaceCamp
//
//  Created by Ehsan on 04/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit
import Foundation
import StoreKit
import AVFoundation

class MainViewController: UIViewController {

    @IBOutlet weak var apodButton: UIButton!
    @IBOutlet weak var marsRoverButton: UIButton!
    
    let parser = JSONParser()
    
    // timer to chnage landing images
    var landingImagesTimer = Timer()
    
    // closure for landing pictures
    let nextLandingImage = StaticImages.nextLandingImage()
    
    var player: AVAudioPlayer?
    
    // this object will be used to send via segue
    // it will get its value from the cache
    var readyApod : ReadyToUseApodObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        
        // global timer to count 240 seconds to ask review from user
        Timer.scheduledTimer(withTimeInterval: StaticProperties.secondsToWaitForReview, repeats: false) { timer in
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            }
        }
        
        guard let path = Bundle.main.path(forResource: StaticProperties.appLaunchSound, ofType: "mp3") else {
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
        
        // hiding apod button until API respond
        apodButton.isHidden = true
        
    }

    
    @objc func changeImage() {
        UIView.transition(with: marsRoverButton, duration: 0.7, options: .transitionFlipFromBottom, animations: {
            self.marsRoverButton.setBackgroundImage(self.nextLandingImage(), for: .normal)
        }, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "apodSegue" {
            if let apodController = segue.destination as? ApodController, let readyApodUnwrapped = readyApod {
                apodController.readyApod = readyApodUnwrapped
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // validating timer coming back to this view
        landingImagesTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
        
        // check the cache if APOD object is available use it
        if let readyToUseApodObject = StaticProperties.cacheObject.object(forKey: "APOD" as AnyObject) as? ReadyToUseApodObject {
            readyApod = readyToUseApodObject
            apodButton.isHidden = false
        } else {
            // if APOD object is not cached fire networking call
            parser.parseApod { apod, error in
                if let error = error {
                    print(error)
                    DispatchQueue.main.sync {
                        switch error {
                        case .notConnectedToInternet:
                            // alert the user about connection
                            self.notConnectedToInternetAlert{ }
                        case .networkConnectionLost:
                            self.notConnectedToInternetAlert{ }
                        case .responseUnsuccessful:
                            self.apiLimitAlert()
                        default:
                            break
                        }
                    }
                }
                
                guard let apod = apod else {
                    print("APOD API is not responding")
                    return
                }
                // unwrapping all the optionals
                if let url = apod.url, let explanation = apod.explanation, let title = apod.title, let hdUrl = apod.hdurl, let media_type = apod.media_type {
                    // by having a url, retrieve the image to cache and show in APOD controller
                    self.parser.client.getData(from: url) { (data, error) in
                        if let data = data {
                            DispatchQueue.main.async {
                                // since API health is ok enable the button
                                UIView.transition(with: self.apodButton, duration: 0.7, options: .transitionCrossDissolve, animations: {
                                    self.apodButton.isHidden = false
                                }, completion: nil)
                            }
                            guard let imageToCache = UIImage(data: data) else {
                                return
                            }
                            
                            let readyToUseApodObject = ReadyToUseApodObject(image: imageToCache, title: title, explanation: explanation, hdUrl: hdUrl, media_type: media_type)
                            self.readyApod = readyToUseApodObject
                            StaticProperties.cacheObject.setObject(readyToUseApodObject as AnyObject, forKey: "APOD" as AnyObject)
                        }
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // invalidate timer when leaving the view
        landingImagesTimer.invalidate()
    }
    
}
