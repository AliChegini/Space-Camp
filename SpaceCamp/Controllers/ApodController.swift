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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(apod)
        
        imageView.image = apod.image
        label.text = apod.title
        textField.text = apod.explanation
        
        // TODO: load hd url and show button if hd image is loaded
        
//        if let url = apod.url, let hdUrl = apod.hdurl, let title = apod.title, let explanation = apod.explanation {
//            parser.client.getData(from: url) { (data, error) in
//                if let data = data {
//                    DispatchQueue.main.async {
//                        self.imageView.image = UIImage(data: data)
//                        self.label.text = title
//                    }
//                }
//            }
//        }
        
    }
    
}
