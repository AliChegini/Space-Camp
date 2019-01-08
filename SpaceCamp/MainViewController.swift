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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("We are ready!")
        
        //apodButton.isEnabled = false
        
        marsRoverButton.setBackgroundImage(ButtonImage.generateRandomImage(), for: .normal)
        
        Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
        
        
        
//        apod.titleLabel?.minimumScaleFactor = 0.5
//        apod.titleLabel?.numberOfLines = 1
//        apod.titleLabel?.baselineAdjustment = .alignCenters
//        apod.titleLabel?.adjustsFontSizeToFitWidth = true
        
    }

    
    @objc func changeImage() {
        UIView.transition(with: marsRoverButton, duration: 1.0, options: .transitionFlipFromBottom, animations: {
            self.marsRoverButton.setBackgroundImage(ButtonImage.generateRandomImage(), for: .normal)
        }, completion: nil)
    }
    

}

