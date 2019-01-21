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
                    // alert the user about no conection
                    let alert = UIAlertController(title: "No Internet Connection", message: "You are not connected to internet! \nPlease  check your connection and try again...", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    alert.presentInOwnWindow(animated: true, completion: nil)
                case .networkConnectionLost:
                    // alert the user about conection lost
                    let alert = UIAlertController(title: "Lost Connection", message: "You have lost your internet connection! \nPlease  check your connection and try again...", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    alert.presentInOwnWindow(animated: true, completion: nil)
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
