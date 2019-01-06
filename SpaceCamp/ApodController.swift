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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Apod:
        // https://api.nasa.gov/planetary/apod?api_key=auLEKaiKVBCr8tO6ZIrWDfBFnj6NQWFrEjrQyQN0
        
        guard let base = URL(string: "https://api.nasa.gov/planetary/apod?api_key=auLEKaiKVBCr8tO6ZIrWDfBFnj6NQWFrEjrQyQN0") else {
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let request = URLRequest(url: base)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            print(data)
        }
        
        dataTask.resume()
        
        
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
