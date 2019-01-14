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

class MainViewController: UIViewController {

    @IBOutlet weak var apodButton: UIButton!
    @IBOutlet weak var marsRoverButton: UIButton!
    
    let parser = JSONParser()
    
    // apodObject to send via segue to ApodController
    var apodObject: Apod?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        
        // Disableing apod button until API respond
        apodButton.isEnabled = false
        // set a random image for rover button to start with
        marsRoverButton.setBackgroundImage(StaticImages.generateRandomImage(), for: .normal)
        
        parser.parseApod { (apod, error) in
            guard let apod = apod else {
                print("apod is nil")
                return
            }
            self.apodObject = apod
            
            if let url = apod.url {
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
                    }
                }
            }
        }
        
        
        Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
        
    }

    
    @objc func changeImage() {
        UIView.transition(with: marsRoverButton, duration: 1.0, options: .transitionFlipFromBottom, animations: {
            self.marsRoverButton.setBackgroundImage(StaticImages.generateRandomImage(), for: .normal)
        }, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "apodSegue" {
            if let apodController = segue.destination as? ApodController {
                if let apodObject = apodObject {
                    apodController.apod = apodObject
                }
            }
        }
    }
    
    
    
}
