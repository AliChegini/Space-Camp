//
//  PhotoSeparator.swift
//  SpaceCamp
//
//  Created by Ehsan on 12/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit

// SemiReady means Images are not retrieved yet, but url of images are ready
struct SemiReadyPhotoObject {
    let url: String
    let dateStamp: String
    let cameraName: String
}

// ReadyPhotoObject means images are retrieved, and ready to use
struct ReadyPhotoObject {
    let image: UIImage
    let dateStamp: String
    let cameraName: String
}


// class to separate photos based on camera names
class PhotoSeparator {
    private let parser = JSONParser()
    
    // asynch function to extract unwrapped properties and separate 5 photos of each camera
    // returns [SemiReadyPhotoObject]
    func prepareSemiReadyArray(roverName: String, date: String, completionHandler completion: @escaping ([SemiReadyPhotoObject]?, SpaceCampError?) -> Void) {
        
        parser.parsePhotos(roverName: roverName, date: date) { (data, error) in
            if let data = data {
                // final array to be returned at completion
                var array: [SemiReadyPhotoObject] = []
                for element in data.photos {
                    if let cameraName = element.camera?.full_name, let date = element.earth_date, let url = element.img_src {
                        // get the count for each camera
                        let count = array.filter{ $0.cameraName == cameraName }.count
                        
                        // 5 photos per camera is enough
                        if count < StaticProperties.numberOfPhotosForEachCamera {
                            // populating the dictionary with unwrapped properties
                            array.append(SemiReadyPhotoObject(url: url, dateStamp: date, cameraName: cameraName))
                        }
                    }
                }
                completion(array, nil)
            } else {
                completion(nil, SpaceCampError.invalidData)
            }
        }
    }
    
    
    func preparePhotos(semiReadyPhotoArray: [SemiReadyPhotoObject], completionHandler completion: @escaping ([ReadyPhotoObject]?, SpaceCampError?) -> Void) {
        
        for item in semiReadyPhotoArray {
            
        }
        
    }
    
    
    
    
}





//        // readyFinalArray to be returned at completion
//        var readyFinalArray: [String : ReadyPhotoObject] = [:]
//
//        let dispatchGroup = DispatchGroup()
//
//        // iterate over finalArray to retrieve images for each url and construct ReadyPhotoObject
//        for item in semiReadyFinalArray {
//
//            dispatchGroup.enter()
//            self.parser.client.getData(from: item.value.url) { (data, error) in
//                if let data = data {
//                    if let image = UIImage(data: data) {
//                        readyFinalArray[item.key] = ReadyPhotoObject(image: image, dateStamp: item.value.dateStamp)
//                        print("from inside asynch call --- \(readyFinalArray)")
//                    }
//                }
//                dispatchGroup.leave()
//            }
//
//        }
//        dispatchGroup.notify(queue: .main, execute: {
//            print("all items are done")
//        })
//
//        completion(readyFinalArray, nil)
//    }
//    completion(nil, SpaceCampError.invalidData)
//}
//
//
