//
//  ButtonImage.swift
//  SpaceCamp
//
//  Created by Ehsan on 08/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import Foundation
import UIKit


class StaticImages {
    private static let landingPageImages = ["SpLanding1", "CurLanding2", "CurLanding", "OppLanding1", "OppLanding2"]
    private static let developerImages = ["pic1", "pic2", "pic3"]
    
    
    typealias LandingImageFunction = () -> UIImage
    // function to return next image for landing page
    static func nextLandingImage() -> ImageFunction {
        
        var localCounter = landingPageImages.count
        
        func decrement() -> UIImage {
            localCounter -= 1
            if localCounter < 0 {
                // reset the counter and minus one to account for 0 index
                localCounter = landingPageImages.count - 1
            }
            return UIImage(imageLiteralResourceName: landingPageImages[localCounter])
        }
        
        return decrement
    }
    
    
    
    typealias ImageFunction = () -> UIImage
    // function to return next image of myself(Ali)
    static func myNextImage() -> ImageFunction {
        
        var localCounter = developerImages.count
        
        func decrement() -> UIImage {
            localCounter -= 1
            if localCounter < 0 {
                // minus one to account for 0 index
                localCounter = developerImages.count - 1
            }
            return UIImage(imageLiteralResourceName: developerImages[localCounter])
        }
        
        return decrement
    }
    
}

