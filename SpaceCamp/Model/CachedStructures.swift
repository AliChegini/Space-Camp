//
//  CachedStructures.swift
//  SpaceCamp
//
//  Created by Ehsan on 21/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit


// Ready Mars Rover Object to keep in cache
// This object will be used to setup cells in collection view, and to construct poster
struct ReadyToUseRoverPhotoObject {
    let image: UIImage
    let camera: String
    let rover: String
    let date: String
}


// Fully constructed APOD Object, unwrapped and ready to use to keep in cache
// This object will be passed from MainViewController to ApodController
struct ReadyToUseApodObject {
    let image: UIImage
    let title: String
    let explanation: String
    let hdUrl: String
    let media_type: String
}

