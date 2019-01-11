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
    
    @IBOutlet weak var launchDate: UILabel!
    @IBOutlet weak var landingDate: UILabel!
    @IBOutlet weak var missionStatus: UILabel!
    @IBOutlet weak var lastPhotoDate: UILabel!
    @IBOutlet weak var totalPhotos: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.timeZone = TimeZone(abbreviation: "GMT")
        
        guard let roverName = roverName else {
            return
        }
        
        parser.parseManifest(for: roverName) { (data, error) in
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
                        
                    }
                }
            }
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoExplorerSegue" {
            if let photoExplorerController = segue.destination as? PhotoExplorerController {
                print("we are here")
                photoExplorerController.roverName = name.text
                photoExplorerController.date = convertDateToString(date: datePicker.date)
            }
        }
    }
    
    
    @IBAction func userPickedDate(_ sender: UIDatePicker) {
        print("from action method \(convertDateToString(date: sender.date))")
    }
    
    
    
    // function to convert String to Date
    // it takes an String -> Date?
    func convertStringToDate(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: string) else {
            return nil
        }
        return date
    }
    
    // function to convert Date to String
    // it takes an Date -> String
    func convertDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let string = dateFormatter.string(from: date)
        
        return string
    }
    

}
