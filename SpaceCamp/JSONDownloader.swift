//
//  JSONDownloader.swift
//  SpaceCamp
//
//  Created by Ehsan on 06/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import Foundation

class JSONDownloader {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping (Data?, SpaceCampError?) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // internet conncetion related errors
            if let error = error as? URLError {
                switch error.code {
                case .notConnectedToInternet:
                    // alert the user
                    print("Not Connceted to Internet")
                case .networkConnectionLost:
                    // Alert the user
                    print("Network Connection Lost")
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
