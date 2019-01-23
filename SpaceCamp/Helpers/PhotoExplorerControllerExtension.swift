//
//  PhotoExplorerControllerExtension.swift
//  SpaceCamp
//
//  Created by Ehsan on 23/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit


extension PhotoExplorerController {
    // function to setup cell
    func configureCell(cell: PhotoCell, indexPath: IndexPath) -> UICollectionViewCell {
        // set placeholder image and label for cells
        cell.imageView.image = UIImage(imageLiteralResourceName: "satellite")
        cell.cameraLabel.text = "Receiving Picture and Camera Name"
        
        // check if the photoObject is available in cache
        if let readyToUseRoverPhotoObject = cache.object(forKey: finalArray[indexPath.row].url as AnyObject) as? ReadyToUseRoverPhotoObject {
            cell.imageView.image = readyToUseRoverPhotoObject.image
            cell.cameraLabel.text = readyToUseRoverPhotoObject.camera
            cell.rover = readyToUseRoverPhotoObject.rover
            cell.date = readyToUseRoverPhotoObject.date
            
            return cell
        } else {
            // if image is not found in cache, fire off getData
            self.parser.client.getData(from: finalArray[indexPath.row].url) { (data, error) in
                if let data = data {
                    guard let imageToCache = UIImage(data: data) else {
                        return
                    }
                    guard let roverName = self.roverName, let date = self.date else {
                        return
                    }
                    // constructing Ready Object to save in cache
                    let readyToUseRoverPhotoObject = ReadyToUseRoverPhotoObject(image: imageToCache, camera: self.finalArray[indexPath.row].cameraName, rover: roverName, date: date)
                    // saving in cache
                    self.cache.setObject(readyToUseRoverPhotoObject as AnyObject, forKey: self.finalArray[indexPath.row].url as AnyObject)
                    
                    DispatchQueue.main.async {
                        // Animating cells while loading
                        UIView.transition(with: cell.imageView, duration: 0.2, options: .transitionCrossDissolve, animations: {
                            cell.imageView.image = readyToUseRoverPhotoObject.image
                            cell.cameraLabel.text = readyToUseRoverPhotoObject.camera
                            cell.rover = readyToUseRoverPhotoObject.rover
                            cell.date = readyToUseRoverPhotoObject.date
                        }, completion: nil)
                    }
                }
            }
        }
        
        return cell
    }
}



extension PhotoExplorerController {
    // function to alert for no photos
    func showNoPhotoAlert() {
        let alert = UIAlertController(title: "No Photos for this Date", message: "Mars Rover did not take any photos on your chosen date\nPlease try another date", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            self.dismiss(animated: true)
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}
