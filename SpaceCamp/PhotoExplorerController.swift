//
//  PhotoExplorerController.swift
//  SpaceCamp
//
//  Created by Ehsan on 11/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit


class PhotoExplorerController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let parser = JSONParser()
    
    var roverName: String?
    var date: String?
    
    var array: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        if let roverName = roverName, let date = date {
//            parser.parsePhotos(roverName: roverName, date: date) { (data, error) in
//                if let data = data {
//                    for element in data.photos {
//                        print(element.camera?.name)
//                    }
//                    // TODO: How do I get the data inside the setupViews()
//                    // to load the data asynchronously I can fetch the photos data in previous view
//                    // then send the photos object to this view
//                    // each cell will fetch data from the url provided to set itself up
//                    // use image cache to avoid unneeded network calls
//                    // also think about a class to iterate over all the photos and pick one for each camera
//
//
//                }
//            }
//        }
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        
        
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as! PhotoCell
        // TODO: instead of having an array of string I should have an array of constructed ready to use objects
        // Refactor later
        if let array = array {
            parser.client.getData(from: array[indexPath.row]) { (data, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.cellImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }


}

class PhotoCell: UICollectionViewCell {
    static let reuseIdentifier = "Cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let separatorView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cellImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setupViews() {
        backgroundColor = UIColor.orange
        addSubview(cellImageView)
        addSubview(separatorView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cellImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cellImageView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": separatorView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(1)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": separatorView]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}






