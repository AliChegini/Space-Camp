//
//  SpaceCampError.swift
//  SpaceCamp
//
//  Created by Ehsan on 06/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import Foundation

enum SpaceCampError: Error {
    case requestFailed
    case responseUnsuccessful
    case invalidURL
    case couldNotConstructUrl
    case notConnectedToInternet
    case networkConnectionLost
}
