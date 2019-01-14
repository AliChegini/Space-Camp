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
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    var roverName: String?
    var date: String?
    var finalArray: [ReadyPhotoObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startActivityIndicator()
        
        if let roverName = roverName, let date = date {
            separator.prepareReadyArray(roverName: roverName, date: date) { (data, error) in
                if let data = data {
                    for item in data {
                        self.finalArray.append(item)
                    }
                    // reloading collectionView from main thread
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    self.stopActivityIndicator()
                }
            }
        }
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "cell")
        
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
        // values are used to maintain aspect ratio of 16 to 9
        // refer to PhotoCell class for padding from top , bottom, left and right
        let height = (view.frame.width - 15 - 15) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 15 + 10 + 20 + 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

