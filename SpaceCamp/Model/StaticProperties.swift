//
//  StaticProperties.swift
//  SpaceCamp
//
//  Created by Ehsan on 09/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit


// enum for rover names
enum Rovers: String {
    case Curiosity
    case Opportunity
    case Spirit
}

// enum for rovers cost
enum RoversCost: String {
    case Curiosity = "2.5 billion USD"
    case Opportunity = "400 Million USD"
    case Spirit = "400 million USD"
}

// struct to hold all the static properties for hard coded values
struct StaticProperties {
    static let arrayOfRoverNames: [Rovers] = [.Curiosity, .Opportunity, .Spirit]
    static let numberOfPhotosForEachCamera = 5
    
}


// photo Object to keep in cache
// This object will be used to setup cells in collection view
struct CachePhotoObject {
    let image: UIImage
    let camera: String
}
