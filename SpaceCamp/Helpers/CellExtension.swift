//
//  CellExtension.swift
//  SpaceCamp
//
//  Created by Ehsan on 19/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit


extension PhotoExplorerController {
    // function to setup cell
    func configureCell(cell: PhotoCell, indexPath: IndexPath) -> UICollectionViewCell {
        cell.imageView.image = UIImage(imageLiteralResourceName: "satellite")
        cell.cameraLabel.text = "Receiving Picture and Camera Name"
        
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
