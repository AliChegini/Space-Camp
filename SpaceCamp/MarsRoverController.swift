//
//  MarsRoverController.swift
//  SpaceCamp
//
//  Created by Ehsan on 07/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit

class MarsRoverController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let parser = JSONParser()
    let client = NasaAPIClient()
    
    @IBOutlet weak var imageViewerMars: UIImageView!
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var label: UILabel!
    
    
    let array = ["Curiosity", "Opportunity", "Spirit"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        picker.dataSource = self
        
        // mars rover link
        // https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2019-01-01&api_key=auLEKaiKVBCr8tO6ZIrWDfBFnj6NQWFrEjrQyQN0
        
        parser.parseRover { (data, error) in
            if let data = data {
                for image in data.photos {
                    //print("\(image.img_src) --- ")
                }
            }
        }
        
        
//        client.getImage(stringUrl: "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/02277/opgs/edr/fcam/FLA_599624843EDR_F0731206FHAZ00341M_.JPG") { (data, error) in
//            if let data = data {
//                DispatchQueue.main.async {
//                    print("mars rover is good")
//                    self.imageViewerMars.image = UIImage(data: data)
//                }
//            }
//        }
        
        // TODO: make a class photo seperator to iterate over the returned images and keep one for each camera
        
        
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch array[row] {
        case "Curiosity":
            imageViewerMars.image = UIImage(imageLiteralResourceName: "cur1")
            label.text = "Curiosity"
        case "Opportunity":
            imageViewerMars.image = UIImage(imageLiteralResourceName: "opp1")
            label.text = "Opportunity"
        case "Spirit":
            imageViewerMars.image = UIImage(imageLiteralResourceName: "sp1")
            label.text = "Spirit"
        default:
            break
        }
    }
    
    
}
