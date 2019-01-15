//
//  Extensions.swift
//  SpaceCamp
//
//  Created by Ehsan on 14/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit

extension UIViewController {
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
    
    
    // function to start activity indicator and block user interactions
    func startActivityIndicator() {
        let alert = UIAlertController(title: nil, message: "Fetching Data...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    // function to stop activity indicator and allow user interactions
    func stopActivityIndicator() {
        dismiss(animated: true, completion: nil)
    }
    
}



extension PhotoExplorerController {
    // function to setup cell
    func configureCell(cell: PhotoCell, indexPath: IndexPath) -> UICollectionViewCell {
        // check if the photoObject is available in cache
        if let photoObjectFromCache = cachedPhotoObject.object(forKey: finalArray[indexPath.row].url as AnyObject) as? CachePhotoObject {
            cell.imageView.image = photoObjectFromCache.image
            cell.cameraLabel.text = photoObjectFromCache.camera
            return cell
        }
        // if image is not found in cache, fire off getData
        self.parser.client.getData(from: finalArray[indexPath.row].url) { (data, error) in
            if let data = data {
                DispatchQueue.main.async {
                    guard let imageToCache = UIImage(data: data) else {
                        return
                    }
                    let cachedPhotoObject = CachePhotoObject(image: imageToCache, camera: self.finalArray[indexPath.row].cameraName)
                    self.cachedPhotoObject.setObject(cachedPhotoObject as AnyObject, forKey: self.finalArray[indexPath.row].url as AnyObject)
                    // Animating cells while loading
                    UIView.transition(with: cell.imageView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        cell.imageView.image = cachedPhotoObject.image
                        cell.cameraLabel.text = cachedPhotoObject.camera
                    }, completion: nil)
                }
            }
        }
        
        return cell
    }
}


