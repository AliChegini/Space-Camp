//
//  PhotoViewerController.swift
//  SpaceCamp
//
//  Created by Ehsan on 15/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit

class PhotoViewerController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    var photo: CachePhotoObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoImageView.image = photo.image
    }
    


}
