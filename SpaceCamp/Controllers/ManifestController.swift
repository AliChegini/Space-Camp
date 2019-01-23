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
        
        // if user is not online, show alert pop the view back to main
        if StaticProperties.isUserOnline == false {
            notConnectedToInternetAlert {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        // timer to keep track of activity indicator for slow connection users
        // progress bar should not block user for more than 15 seconds
        Timer.scheduledTimer(withTimeInterval: StaticProperties.timeOutDuration, repeats: false) { timer in
            if StaticProperties.isActivityIndicatorOn == true {
                self.stopActivityIndicator {
                    // show time out feedback
                    self.timeOutFeedback()
                }
            }
        }
        startActivityIndicator()
        
        
        button.roundButton()
        button.isHidden = true
        
        datePicker.timeZone = TimeZone(abbreviation: "GMT")
        
        guard let roverName = roverName else {
            return
        }
        // network call 
        parser.parseManifest(for: roverName) { data, error in
            
            if let data = data {
                // Unwapping all the properties from manifest and populating labels
                if let launchDateUnwrapped = data.photo_manifest.launch_date, let landingDateUnwrapped = data.photo_manifest.landing_date, let missionDateUnwrapped = data.photo_manifest.status, let lastPhotoDateUnwrapped = data.photo_manifest.max_date, let totalPhotosUnwrapped = data.photo_manifest.total_photos, let nameUnwrapped = data.photo_manifest.name {
                    // get to main to update UI
                    DispatchQueue.main.async {
                        UIView.transition(with: self.launchDate, duration: 0.4, options: .transitionFlipFromRight, animations: {
                            self.launchDate.text = launchDateUnwrapped
                        }, completion: nil)
                        
                        UIView.transition(with: self.landingDate, duration: 0.6, options: .transitionFlipFromRight, animations: {
                            self.landingDate.text = landingDateUnwrapped
                        }, completion: nil)
                        
                        UIView.transition(with: self.missionStatus, duration: 0.8, options: .transitionFlipFromRight, animations: {
                            self.missionStatus.text = missionDateUnwrapped
                        }, completion: nil)
                        
                        UIView.transition(with: self.lastPhotoDate, duration: 1.0, options: .transitionFlipFromRight, animations: {
                            self.lastPhotoDate.text = lastPhotoDateUnwrapped
                        }, completion: nil)
                        
                        UIView.transition(with: self.totalPhotos, duration: 1.2, options: .transitionFlipFromRight, animations: {
                            self.totalPhotos.text = "\(totalPhotosUnwrapped)"
                        }, completion: nil)
                        
                        UIView.transition(with: self.name, duration: 1.4, options: .transitionFlipFromRight, animations: {
                            self.name.text = nameUnwrapped
                        }, completion: nil)
                        
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
                            UIView.transition(with: self.button, duration: 1.0, options: .transitionFlipFromRight, animations: {
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
