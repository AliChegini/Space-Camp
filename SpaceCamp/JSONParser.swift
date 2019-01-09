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
            let decoder = JSONDecoder()
            guard let data = data else {
                completion(nil, SpaceCampError.invalidData)
                return
            }
            
            if let readyApod = try? decoder.decode(Apod.self, from: data) {
                completion(readyApod, nil)
            }
        }
    }
    
    
    // function to parse json response and prepare ready to use Manifest Object
    func parseManifest(for rover: String, completionHandler completion: @escaping (RoverManifest?, SpaceCampError?) -> Void) {
        let urlString = "\(client.baseManifestUrl)\(rover)\(client.apiKeyWithSymbols)"
        client.getData(from: urlString) { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else {
                completion(nil, SpaceCampError.invalidData)
                return
            }
            
            if let readyManifest = try? decoder.decode(RoverManifest.self, from: data) {
                completion(readyManifest, nil)
            }
        }
    }
    
    
    
    
    // function to parse json response and prepare read to use MarsRover object
//    func parseRover(completionHandler completion: @escaping (MarsRoverPhotos?, SpaceCampError?) -> Void) {
//        client.getRover { (data, error) in
//            let decoder = JSONDecoder()
//            guard let data = data else {
//                completion(nil, SpaceCampError.invalidData)
//                return
//            }
//
//            if let response = try? decoder.decode(MarsRoverPhotos.self, from: data) {
//                //print(response)
//                completion(response, nil)
//            }
//        }
//    }
    
    
    
    
}



