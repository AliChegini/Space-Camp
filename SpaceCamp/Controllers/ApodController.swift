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
        
        zoomButton.roundButton()
        developerButton.roundButton()
        
        imageView.image = apod.image
        label.text = apod.title
        textField.text = apod.explanation
        
        // check if hd image is cached don't fire get data
        parser.client.getData(from: apod.hdUrl) { (data, error) in
            if let data = data {
                guard let hdImage = UIImage(data: data) else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.zoomButton.isHidden = false
                }
                // TODO: remebr to cach the hd image here and send/ show from the cache
                
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
