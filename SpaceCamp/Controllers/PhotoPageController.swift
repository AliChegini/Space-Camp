//
//  PhotoPageController.swift
//  SpaceCamp
//
//  Created by Ehsan on 15/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit

class PhotoPageController: UIPageViewController {
    
    var photo: CachePhotoObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let storyboard = storyboard, let photoViewerController = storyboard.instantiateViewController(withIdentifier: "PhotoViewerController") as? PhotoViewerController else {
            return
        }
        
        
        photoViewerController.photo = photo
        setViewControllers([photoViewerController], direction: .forward, animated: false, completion: nil)
        
        
    }
    

}
