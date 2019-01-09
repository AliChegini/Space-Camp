//
//  ManifestController.swift
//  SpaceCamp
//
//  Created by Ehsan on 09/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit

class ManifestController: UIViewController {

    var roverName: String?
    
    let parser = JSONParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // link for curiosity manifest
        // https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=auLEKaiKVBCr8tO6ZIrWDfBFnj6NQWFrEjrQyQN0
        
        
        guard let roverName = roverName else {
            return
        }
        
        parser.parseManifest(for: roverName) { (manifest, error) in
            if let manifest = manifest {
                print(manifest.photo_manifest)
            }
        }
        
        
        
    }
    



}
