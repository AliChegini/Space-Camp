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
    
    let cachedPhotoObject = NSCache<AnyObject, AnyObject>()
    
    var roverName: String?
    var date: String?
    var finalArray: [ReadyPhotoObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Make a PostCard", style: .plain, target: self, action: nil)
        startActivityIndicator()
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "cell")
        
        if let roverName = roverName, let date = date {
            separator.prepareReadyArray(roverName: roverName, date: date) { (data, error) in
                if let data = data {
                    for item in data {
                        self.finalArray.append(item)
                    }
                    
                    self.finalArray.sort { $0.cameraName < $1.cameraName }
                    
                    // reloading collectionView from main thread
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.stopActivityIndicator {
                            if self.finalArray.count == 0 {
                                print("final array count is \(self.finalArray.count)")
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
            if let cell = sender as? PhotoCell, let indexPath = collectionView.indexPath(for: cell), let photoZoomController = segue.destination as? PhotoZoomController {
                if let cachedObject = cachedPhotoObject.object(forKey: finalArray[indexPath.row].url as AnyObject) as? CachePhotoObject {
                    photoZoomController.photo = cachedObject
                }
            }
        }
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
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        // perform segue and having cell as sender,
        // cell info will be used in prepareForSegue method
        performSegue(withIdentifier: "showPhotoSegue", sender: cell)
    }
    
}

