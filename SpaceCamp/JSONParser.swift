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
    
    // function to parse json response and prepare read to use Apod object
    func parseApod(completionHandler completion: @escaping (Apod?, SpaceCampError?) -> Void) {
        client.getAPOD { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else {
                completion(nil, SpaceCampError.invalidData)
                return
            }
            
            if let response = try? decoder.decode(Apod.self, from: data) {
                completion(response, nil)
            }
        }
    }
    
    
    // function to parse json response and prepare read to use MarsRover object
    func parseRover(completionHandler completion: @escaping (MarsRoverPhotos?, SpaceCampError?) -> Void) {
        client.getRover { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else {
                completion(nil, SpaceCampError.invalidData)
                return
            }
            
            if let response = try? decoder.decode(MarsRoverPhotos.self, from: data) {
                //print(response)
                completion(response, nil)
            }
        }
    }
    
    
    
    
}



