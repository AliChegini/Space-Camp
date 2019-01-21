//
//  ApodController.swift
//  SpaceCamp
//
//  Created by Ehsan on 04/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit
import Foundation

class ApodController: UIViewController {
    let parser = JSONParser()
    
    var readyApod: ReadyToUseApodObject?
    var highQualityImage: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var zoomButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Picture of the Day"
        
        // hide Zoom button until hd image gets loaded
        zoomButton.isHidden = true
        zoomButton.roundButton()
        
        guard let readyApod = readyApod else {
            return
        }
        
        imageView.image = readyApod.image
        label.text = readyApod.title
        textField.text = readyApod.explanation
        
        
        // if hd image is not cached fire off networking call
        parser.client.getData(from: readyApod.hdUrl) { (data, error) in
            if let data = data {
                guard let hdImage = UIImage(data: data) else {
                    return
                }
                
                self.highQualityImage = hdImage
                
                DispatchQueue.main.async {
                    UIView.transition(with: self.zoomButton, duration: 0.6, options: .transitionFlipFromBottom, animations: {
                        self.zoomButton.isHidden = false
                    }, completion: nil)
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "zoomHDSegue" {
            if let apodZoomController = segue.destination as? ApodZoomController {
                apodZoomController.hdPhoto = highQualityImage
            }
        }
    }
    
}
