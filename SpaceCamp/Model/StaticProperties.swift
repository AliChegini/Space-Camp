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
    
    // sound track names
    static let developerSound = "PianoIntro"
    static let appLaunchSound = "AppLaunch"
    static let beepSound = "Beep"
    static let opportunityRoverSound = "Opportunity"
    static let curiosityRoverSound = "Curiosity"
    static let spiritRoverSound = "Spirit"
    
    static let secondsToWaitForReview = 240.0
    
    static var isActivityIndicatorOn: Bool = false
    
    static var isUserOnline: Bool = true
    
    static let timeOutDuration = 15.0
    
    static let maximumZoomScale: CGFloat = 1.5
    
    // postCardScale will be used for sizing the font and text position on the postcard
    static let postCardScale: CGFloat = 20.0
    
    // will be used to cache (only) apod object if available
    static var cacheObject = NSCache<AnyObject, AnyObject>()
    
}
