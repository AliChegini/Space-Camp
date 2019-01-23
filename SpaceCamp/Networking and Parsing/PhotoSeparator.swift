//
//  PhotoSeparator.swift
//  SpaceCamp
//
//  Created by Ehsan on 12/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit


struct ReadyPhotoObject {
    let url: String
    let dateStamp: String
    let cameraName: String
}


// class to separate photos based on camera names
class PhotoSeparator {
    private let parser = JSONParser()
    
    // asynch function to extract unwrapped properties and separate 5 photos of each camera
    // returns [ReadyPhotoObject] at completion
    func prepareReadyPhotoArray(roverName: String, date: String, completionHandler completion: @escaping ([ReadyPhotoObject]?, SpaceCampError?) -> Void) {
        
        parser.parsePhotos(roverName: roverName, date: date) { (data, error) in
            if let error = error {
                completion(nil, error)
            }
            
            if let data = data {
                // final array to be returned at completion
                var array: [ReadyPhotoObject] = []
                
                for element in data.photos {
                    if let cameraName = element.camera?.full_name, let date = element.earth_date, let url = element.img_src {
                        // get the count for each camera
                        let count = array.filter{ $0.cameraName == cameraName }.count
                        
                        // 5 photos per camera is enough
                        if count < StaticProperties.numberOfPhotosForEachCamera {
                            let readyPhotoObject = ReadyPhotoObject(url: url, dateStamp: date, cameraName: cameraName)
                            // populating the array with unwrapped properties
                            array.append(readyPhotoObject)
                        }
                    }
                }
                completion(array, nil)
            }
        }
    }
    
}
