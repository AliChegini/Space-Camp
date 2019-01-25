//
//  PhotoExplorerController.swift
//  SpaceCamp
//
//  Created by Ehsan on 11/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit


class PhotoExplorerController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let separator = PhotoSeparator()
    let parser = JSONParser()
    
    let cache = NSCache<AnyObject, AnyObject>()
    
    var roverName: String?
    var date: String?
    
    // timer to keep track of activity indicator
    var timer = Timer()
    
    var finalArray: [ReadyPhotoObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // if user is not online, show alert pop the view back to main
        if StaticProperties.isUserOnline == false {
            notConnectedToInternetAlert {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "cell")
        
        if let roverName = roverName, let date = date {
            // timer to keep track of activity indicator for slow connection users
            // progress bar should not block user for more than 15 seconds
            timer = Timer.scheduledTimer(withTimeInterval: StaticProperties.timeOutDuration, repeats: false) { timer in
                if StaticProperties.isActivityIndicatorOn == true {
                    self.stopActivityIndicator {
                        // show time out feedback
                        self.timeOutFeedback()
                    }
                }
            }
            
            // start activity indicator
            startActivityIndicator()
            
            separator.prepareReadyPhotoArray(roverName: roverName, date: date) { data, error in
                if let error = error {
                    print("Error occured inside prepareReadyPhotoArray \(error)")
                    switch error {
                    case .responseUnsuccessful:
                        DispatchQueue.main.sync {
                            self.apiLimitAlert()
                        }
                    default:
                        break
                    }
                }
                
                if let data = data {
                    for item in data {
                        self.finalArray.append(item)
                    }
                    
                    self.finalArray.sort { $0.cameraName < $1.cameraName }
                    
                    // reloading collectionView from main thread
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.stopActivityIndicator {
                            // if finalArray count is zero alert the user
                            if self.finalArray.count == 0 {
                                self.showNoPhotoAlert()
                            }
                        }
                    }
                    
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotoSegue" {
            if let cell = sender as? PhotoCell, let photoZoomController = segue.destination as? PhotoZoomController {
                
                if let image = cell.imageView.image, let camera = cell.cameraLabel.text {
                    let photoObject = ReadyToUseRoverPhotoObject(image: image , camera: camera, rover: cell.rover, date: cell.date)
                    photoZoomController.photoObject = photoObject
                }
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return finalArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell
        
        return configureCell(cell: cell, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // values are used to maintain aspect ratio of 4 to 3
        // refer to PhotoCell class for padding from top , bottom, left and right
        let height = (view.frame.width - 10 - 10) * 3 / 4
        return CGSize(width: view.frame.width, height: height + 15 + 10 + 20 + 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // getting the cell using indexPath
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell else {
            return
        }
        
        // check if the cell is populated with fetched data(image and label)
        // placeholder image named "satellite" is been used to populate cells while loading data
        if cell.imageView.image != UIImage(imageLiteralResourceName: "satellite") && cell.cameraLabel.text != "Receiving Picture and Camera Name" {
            // perform segue and having cell as sender,
            // cell info will be used in prepareForSegue method
            performSegue(withIdentifier: "showPhotoSegue", sender: cell)
        }
    }
    
}
