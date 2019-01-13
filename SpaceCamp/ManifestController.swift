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
    @IBOutlet weak var button: UIButton!
    let activityIndicator = UIActivityIndicatorView()
    
    var arrayOfUrls: [String] = []
    
    let separator = PhotoSeparator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // hide the button til user pick a date
        button.isHidden = true
        startActivityIndicator()
        
        
        
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
                    // stop activity indicator after populating labels
                    self.stopActivityIndicator()
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
                photoExplorerController.array = arrayOfUrls
            }
        }
    }
    
    
    
    
    @IBAction func userPickedDate(_ sender: UIDatePicker) {
        startActivityIndicator()
        if let name = name.text {
            // fetching Photos Object to send via segue
            parser.parsePhotos(roverName: name, date: convertDateToString(date: sender.date)) { (data, error) in
                if let data = data {
                    for element in data.photos {
                        if let url = element.img_src {
                            self.arrayOfUrls.append(url)
                        }
                    }
                    DispatchQueue.main.async {
                        self.button.isHidden = false
                        self.stopActivityIndicator()
                    }

                }


            }
        }
        
        
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


extension UIViewController {
    func startActivityIndicator() {
        let alert = UIAlertController(title: nil, message: "Fetching Data...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func stopActivityIndicator() {
        dismiss(animated: true, completion: nil)
    }
}
