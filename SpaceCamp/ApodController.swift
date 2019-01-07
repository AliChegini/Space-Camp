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
    let client = NasaAPIClient()
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // APOD is not always responding fast, workaround, disable/hidden the button if API is not responding in the main view, if it is responding quickly do the work in main view
        
        
        client.getImage(stringUrl: "https://apod.nasa.gov/apod/image/1901/Geminids46P_jcc_1080.jpg", completionHandler: { (data, error) in
            if let data = data {
                DispatchQueue.main.async {
                    print("data is \(data)")
                    self.imageView.image = UIImage(data: data)
                    
                }
            }
        })
        
        
        
        parser.parse { (apod, error) in
            if let apod = apod {
                if let url = apod.url {
                    print(url)
                }
            } else {
                print("apod is nil")
            }
        }
        
        
        
        
        
        
        // ----------------------------------------------------
        // Mars Rover endpoint
        // Earth date
        // https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3&api_key=DEMO_KEY
        
        // https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=fhaz&api_key=DEMO_KEY
        
        // Mission manifest
        //A mission manifest is available for each Rover at /manifests/rover_name.
        
        // Idea for mars rover
        // changing the camera with cool sounds - Front to Rear
        
    }
    
}
