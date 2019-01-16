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
    
    @IBOutlet weak var imageViewerMars: UIImageView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        picker.dataSource = self
        
        // hide the button until user rotate the wheel
        button.isHidden = true
        
        button.layer.cornerRadius = 10
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "manifestSegue" {
            if let manifestController = segue.destination as? ManifestController {
                if label.text != "Choose a Rover" {
                    // sending the rover name to ManifestController
                    manifestController.roverName = label.text?.lowercased()
                }
            }
        }
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return StaticProperties.arrayOfRoverNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return StaticProperties.arrayOfRoverNames[row].rawValue
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // show the button
        button.isHidden = false
        switch StaticProperties.arrayOfRoverNames[row] {
        case Rovers.Curiosity:
            UIView.transition(with: imageViewerMars, duration: 0.4, options: .transitionFlipFromBottom, animations: {
                self.imageViewerMars.image = UIImage(imageLiteralResourceName: "curiosity3")
            }, completion: nil)
            label.text = Rovers.Curiosity.rawValue
            
        case Rovers.Opportunity:
            UIView.transition(with: imageViewerMars, duration: 0.4, options: .transitionFlipFromBottom, animations: {
                self.imageViewerMars.image = UIImage(imageLiteralResourceName: "opp1")
            }, completion: nil)
            label.text = Rovers.Opportunity.rawValue
            
        case Rovers.Spirit:
            UIView.transition(with: imageViewerMars, duration: 0.4, options: .transitionFlipFromBottom, animations: {
                self.imageViewerMars.image = UIImage(imageLiteralResourceName: "sp1")
            }, completion: nil)
            label.text = Rovers.Spirit.rawValue
        }
    }
    
    
}

