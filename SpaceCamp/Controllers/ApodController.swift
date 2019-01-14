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
    
    var apod: Apod?
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let apod = apod else {
            return
        }
        
        if let url = apod.url, let hdUrl = apod.hdurl, let title = apod.title, let explanation = apod.explanation {
            parser.client.getData(from: url) { (data, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                        self.label.text = title
                    }
                }
            }
        }
        
    }
    
}
