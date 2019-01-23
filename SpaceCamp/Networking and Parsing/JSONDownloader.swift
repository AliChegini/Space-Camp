//
//  JSONDownloader.swift
//  SpaceCamp
//
//  Created by Ehsan on 06/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import Foundation
import UIKit

class JSONDownloader {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    // function to download and return dataTask
    // returned dataTask will be used by functions in client class
    func jsonDownloader(with request: URLRequest, completionHandler completion: @escaping (Data?, SpaceCampError?) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // internet conncetion related errors
            if let error = error as? URLError {
                switch error.code {
                case .notConnectedToInternet:
                    StaticProperties.isUserOnline = false
                    completion(nil, .notConnectedToInternet)
                case .networkConnectionLost:
                    StaticProperties.isUserOnline = false
                    completion(nil, .networkConnectionLost)
                default:
                    break
                }
            } else {
                // if there is no error user is online
                StaticProperties.isUserOnline = true
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    completion(data, nil)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
            
        }
        
        return task
    }
    
    
}
