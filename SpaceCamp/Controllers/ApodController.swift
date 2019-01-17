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
    
    var apod: CacheApodObject!
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var zoomButton: UIButton!
    @IBOutlet weak var developerButton: UIButton!
    
    var highQualityImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Picture of the Day"
        
        // hide Zoom button until hd image gets loaded
        zoomButton.isHidden = true
        
        zoomButton.layer.cornerRadius = 10
        developerButton.layer.cornerRadius = 10
        
        imageView.image = apod.image
        label.text = apod.title
        textField.text = apod.explanation
        
        parser.client.getData(from: apod.hdUrl) { (data, error) in
            if let data = data {
                guard let hdImage = UIImage(data: data) else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.zoomButton.isHidden = false
                }
                
                self.highQualityImage = hdImage
                
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
