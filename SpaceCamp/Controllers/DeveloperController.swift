//
//  DeveloperController.swift
//  SpaceCamp
//
//  Created by Ehsan on 17/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit


class DeveloperController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var techLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "About Developer"
        
        playSound(track: StaticProperties.developerSoundName, id: &StaticProperties.developerSoundID)
        
        imageView.center.x = self.view.frame.width + 200
        titleLabel.center.x = self.view.frame.width + 200
        techLabel.center.x = self.view.frame.width + 200
        
        UIView.animate(withDuration: 5.0, delay: 0.2, usingSpringWithDamping: 4.0, initialSpringVelocity: 5, options: .curveLinear, animations: {
            self.imageView.center.x = self.view.frame.width / 2
        }, completion: nil)
        
        UIView.animate(withDuration: 4.0, delay: 1.2, usingSpringWithDamping: 4.0, initialSpringVelocity: 10, options: .curveLinear, animations: {
            self.titleLabel.center.x = self.view.frame.width / 2
        }, completion: nil)
        
        UIView.animate(withDuration: 3.0, delay: 2.2, usingSpringWithDamping: 1.0, initialSpringVelocity: 3, options: .curveLinear, animations: {
            self.techLabel.center.x = self.view.frame.width / 2
        }, completion: nil)
        
    }
    
}