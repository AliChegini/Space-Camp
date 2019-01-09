//
//  NasaAPICilent.swift
//  SpaceCamp
//
//  Created by Ehsan on 07/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import Foundation

// class to interact with NASA API
class NasaAPIClient {
    private let downloader = JSONDownloader()
    
    fileprivate let apiKey = "auLEKaiKVBCr8tO6ZIrWDfBFnj6NQWFrEjrQyQN0"
    
    let apiKeyWithSymbols = "?api_key=auLEKaiKVBCr8tO6ZIrWDfBFnj6NQWFrEjrQyQN0"
    
    let apodUrl = "https://api.nasa.gov/planetary/apod?api_key=auLEKaiKVBCr8tO6ZIrWDfBFnj6NQWFrEjrQyQN0"
    
    let marsRoverUrl = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2019-01-01&api_key=auLEKaiKVBCr8tO6ZIrWDfBFnj6NQWFrEjrQyQN0"
    
    let baseManifestUrl = "https://api.nasa.gov/mars-photos/api/v1/manifests/"

    
    // function to retrieve data from a string url
    func getData(from stringUrl: String, completionHandler completion: @escaping (Data?, SpaceCampError?) -> Void) {
        guard let url = URL(string: stringUrl) else {
            completion(nil, SpaceCampError.couldNotConstructUrl)
            return
        }
        
        let request = URLRequest(url: url)
        let task = downloader.jsonDownloader(with: request) { (data, error) in
            if let data = data {
                completion(data, nil)
            }
        }
        task.resume()
    }
    
}





