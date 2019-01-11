//
//  PhotoExplorerController.swift
//  SpaceCamp
//
//  Created by Ehsan on 11/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PhotoExplorerController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let parser = JSONParser()
    
    var roverName: String?
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let roverName = roverName, let date = date {
            parser.parsePhotos(roverName: roverName, date: date) { (data, error) in
                if let data = data {
                    for element in data.photos {
                        print(element.camera?.name)
                    }
                    // TODO: How do I get the data inside the setupViews()
                    // to load the data asynchronously I can fetch the photos data in previous view
                    // then send the photos object to this view
                    // each cell will fetch data from the url provided to set itself up
                    // use image cache to avoid unneeded network calls
                    // also think about a class to iterate over all the photos and pick one for each camera
                    
                    
                }
            }
        }
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }


}

class PhotoCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor.orange
        //addSubview(<#T##view: UIView##UIView#>)
    }
    
    
}






