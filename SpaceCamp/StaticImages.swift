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
    private static let imageArray = ["opp1", "opp2", "curiosity1", "curiosity2", "curiosity3", "mars1", "mars2", "mars3", "mars4", "mars5", "mars6", "mars7", "mars8", "sp1", "mars3", "mars4", "mars5", "mars6", "mars6", "curiosity2", "mars6"]
    
    static func generateRandomImage() -> UIImage{
        let random = Int(arc4random_uniform(UInt32(imageArray.count)))
        //print(random)
        return UIImage(imageLiteralResourceName: imageArray[random])
    }
    
}

