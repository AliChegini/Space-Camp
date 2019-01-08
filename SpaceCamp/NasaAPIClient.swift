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
    let downloader = JSONDownloader()
    
    // Apod Link:
    // https://api.nasa.gov/planetary/apod?date=2018-01-01&api_key=auLEKaiKVBCr8tO6ZIrWDfBFnj6NQWFrEjrQyQN0
    fileprivate let apiKey = "auLEKaiKVBCr8tO6ZIrWDfBFnj6NQWFrEjrQyQN0"
    
    let apodUrl = URL(string: "https://api.nasa.gov/planetary/apod?date=2019-01-01&api_key=auLEKaiKVBCr8tO6ZIrWDfBFnj6NQWFrEjrQyQN0")
    
    let marsRoverUrl = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2019-01-01&api_key=auLEKaiKVBCr8tO6ZIrWDfBFnj6NQWFrEjrQyQN0")
    
    // function to retrieve data for Astronomy Picture of the Day (APOD)
    func getAPOD(completionHandler completion: @escaping (Data?, SpaceCampError?) -> Void) {
        guard let url = apodUrl else {
            completion(nil, SpaceCampError.couldNotConstructUrl)
            return
        }
        let request = URLRequest(url: url)
        
        let task = downloader.jsonDownloader(with: request) { (data, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
        
        task.resume()
    }
    
    
    // function to retrieve data for Astronomy Picture of the Day (APOD)
    func getRover(completionHandler completion: @escaping (Data?, SpaceCampError?) -> Void) {
        guard let url = marsRoverUrl else {
            completion(nil, SpaceCampError.couldNotConstructUrl)
            return
        }
        let request = URLRequest(url: url)
        
        let task = downloader.jsonDownloader(with: request) { (data, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
        
        task.resume()
    }
    
    
    
    // function to retrieve the image using a link
    func getImage(stringUrl: String, completionHandler completion: @escaping (Data?, SpaceCampError?) -> Void) {
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
    
    // TODO: All of theabove functions needs to be refactored since they all have same implementation
    
}





