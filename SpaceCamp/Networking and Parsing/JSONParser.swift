//
//  JSONParser.swift
//  SpaceCamp
//
//  Created by Ehsan on 07/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import Foundation


class JSONParser {
    let client = NasaAPIClient()
    
    // function to parse json response and prepare ready to use Apod object
    func parseApod(completionHandler completion: @escaping (Apod?, SpaceCampError?) -> Void) {
        client.getData(from: client.apodUrl) { (data, error) in
            if let error = error {
                completion(nil, error)
            }
            
            guard let data = data else {
                completion(nil, SpaceCampError.invalidData)
                return
            }
            
            let decoder = JSONDecoder()
            if let readyApod = try? decoder.decode(Apod.self, from: data) {
                completion(readyApod, nil)
            }
        }
    }
    
    
    // function to parse json response and prepare ready to use Manifest Object
    func parseManifest(for rover: String, completionHandler completion: @escaping (RoverManifest?, SpaceCampError?) -> Void) {
        // Example URL: https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=auLEKaiKVBCr8tO6ZIrWDfBFnj6NQWFrEjrQyQN0
        // Constructing a url to retrieve Manifest Object
        let urlString = "\(client.baseManifestUrl)\(rover)?\(client.apiKeyWithPrefix)"
        client.getData(from: urlString) { (data, error) in
            if let error = error {
                completion(nil, error)
            }
            
            guard let data = data else {
                completion(nil, SpaceCampError.invalidData)
                return
            }
            
            let decoder = JSONDecoder()
            if let readyManifest = try? decoder.decode(RoverManifest.self, from: data) {
                completion(readyManifest, nil)
            }
        }
    }
    
    
    // function to parse json response and prepare ready to use MarsRoverPhotos Object
    func parsePhotos(roverName: String, date: String, completionHandler completion: @escaping (MarsRoverPhotos?, SpaceCampError?) -> Void) {
        // URL example : https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2019-01-01&api_key=auLEKaiKVBCr8tO6ZIrWDfBFnj6NQWFrEjrQyQN0
        // Constructing a url to retrieve MarsRover photos
        let urlString = "\(client.baseMarsRoverUrl)\(roverName)\(client.earthDateWithPrefix)\(date)&page=1&\(client.apiKeyWithPrefix)"
        client.getData(from: urlString) { (data, error) in
            if let error = error {
                completion(nil, error)
            }
            
            guard let data = data else {
                completion(nil, SpaceCampError.invalidData)
                return
            }
            
            let decoder = JSONDecoder()
            if let readyPhotos = try? decoder.decode(MarsRoverPhotos.self, from: data) {
                completion(readyPhotos, nil)
            }
        }
    }
    
}

