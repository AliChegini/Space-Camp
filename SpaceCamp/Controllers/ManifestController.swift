//
//  ManifestController.swift
//  SpaceCamp
//
//  Created by Ehsan on 09/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit

class ManifestController: UIViewController {

    let parser = JSONParser()
    
    @IBOutlet weak var launchDate: UILabel!
    @IBOutlet weak var landingDate: UILabel!
    @IBOutlet weak var missionStatus: UILabel!
    @IBOutlet weak var lastPhotoDate: UILabel!
    @IBOutlet weak var totalPhotos: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var button: UIButton!
    
    var roverName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startActivityIndicator()
        // timer to keep track of activity indicator for slow connection users
        // progress bar should not block user for more than 15 seconds
        Timer.scheduledTimer(withTimeInterval: 15, repeats: false) { timer in
            if StaticProperties.isActivityIndicatorOn == true {
                self.stopActivityIndicator {
                    // show time out feedback
                    self.timeOutFeedback()
                }
            }
        }
        
        button.roundButton()
        button.isHidden = true
        
        datePicker.timeZone = TimeZone(abbreviation: "GMT")
        
        guard let roverName = roverName else {
            return
        }
        // network call 
        parser.parseManifest(for: roverName) { data, error in
            if let error = error {
                print(error)
                switch error {
                case .notConnectedToInternet:
                    print("Inside .notConnectedToInternet case ---")
                    if StaticProperties.isActivityIndicatorOn == true {
                        print("isActivityIndicatorOn \(StaticProperties.isActivityIndicatorOn)")
                        DispatchQueue.main.async {
                            self.stopActivityIndicator {
                                print("Activity indicator is stopped")
                                //self.notConnectedToInternetAlert()
                            }
                        }
                    }
//                    case .networkConnectionLost:
                    //self.timeOutFeedback()
                default:
                    break
                }
                
            }
            
            if let data = data {
                // Unwapping all the properties from manifest and populating labels
                if let launchDateUnwrapped = data.photo_manifest.launch_date, let landingDateUnwrapped = data.photo_manifest.landing_date, let missionDateUnwrapped = data.photo_manifest.status, let lastPhotoDateUnwrapped = data.photo_manifest.max_date, let totalPhotosUnwrapped = data.photo_manifest.total_photos, let nameUnwrapped = data.photo_manifest.name {
                    
                    DispatchQueue.main.async {
                        self.launchDate.text = launchDateUnwrapped
                        self.landingDate.text = landingDateUnwrapped
                        self.missionStatus.text = missionDateUnwrapped
                        self.lastPhotoDate.text = lastPhotoDateUnwrapped
                        self.totalPhotos.text = "\(totalPhotosUnwrapped)"
                        self.name.text = nameUnwrapped
                        
                        if let begin = self.convertStringToDate(string: landingDateUnwrapped) {
                            self.datePicker.minimumDate = begin
                        }
                        
                        if let end = self.convertStringToDate(string: lastPhotoDateUnwrapped) {
                            self.datePicker.maximumDate = end
                            self.datePicker.setDate(end, animated: true)
                        }
                    
                        switch nameUnwrapped {
                        case Rovers.Curiosity.rawValue:
                            self.cost.text = RoversCost.Curiosity.rawValue
                        case Rovers.Opportunity.rawValue:
                            self.cost.text = RoversCost.Opportunity.rawValue
                        case Rovers.Spirit.rawValue:
                            self.cost.text = RoversCost.Spirit.rawValue
                        default:
                            break
                        }
                        
                        // stop activity indicator after populating labels
                        self.stopActivityIndicator {
                            UIView.transition(with: self.button, duration: 0.3, options: .transitionFlipFromTop, animations: {
                                self.button.isHidden = false
                            }, completion: nil)
                        }
                        
                    }
                    
                }
            }
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoExplorerSegue" {
            if let photoExplorerController = segue.destination as? PhotoExplorerController {
                photoExplorerController.roverName = name.text?.lowercased()
                photoExplorerController.date = convertDateToString(date: datePicker.date)
            }
        }
    }
    
    
    @IBAction func userPickedDate(_ sender: UIDatePicker) {
        print("from action method \(convertDateToString(date: sender.date))")
    }
    
}
