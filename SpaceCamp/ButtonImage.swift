//
//  ButtonImage.swift
//  SpaceCamp
//
//  Created by Ehsan on 08/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import Foundation
import UIKit


class ButtonImage {
    private static let imageArray = ["opp1", "opp2", "cur1", "cur2", "sp1"]
    
    static func generateRandomImage() -> UIImage{
        let random = Int(arc4random_uniform(UInt32(imageArray.count)))
        print(random)
        return UIImage(imageLiteralResourceName: imageArray[random])
    }
    
}





