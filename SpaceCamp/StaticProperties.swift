//
//  StaticProperties.swift
//  SpaceCamp
//
//  Created by Ehsan on 09/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import Foundation



// enum for rover names
enum Rovers: String {
    case Curiosity
    case Opportunity
    case Spirit
}

// struct to hold all the static properties for hard coded values
struct StaticProperties {
    static let arrayOfRoverNames: [Rovers] = [.Curiosity, .Opportunity, .Spirit]
    
    
}

