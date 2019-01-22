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
    
    // function to download and return data to memory
    // returned data will be consumed by functions in client class
    func jsonDownloader(with request: URLRequest, completionHandler completion: @escaping (Data?, SpaceCampError?) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // internet conncetion related errors
            if let error = error as? URLError {
                switch error.code {
                case .notConnectedToInternet:
                    completion(nil, SpaceCampError.notConnectedToInternet)
                case .networkConnectionLost:
                    completion(nil, SpaceCampError.networkConnectionLost)
                default:
                    break
                }
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    //print(httpResponse.allHeaderFields.debugDescription)
                    completion(data, nil)
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
            
        }
        
        return task
    }
    
    
}
