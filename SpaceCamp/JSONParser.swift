//
//  JSONParser.swift
//  SpaceCamp
//
//  Created by Ehsan on 07/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import Foundation


struct Apod: Decodable {
    let title: String?
    let url: String?
    let hdurl: String?
    let explanation: String?
}


class JSONParser {
    let client = NasaAPIClient()
    
    // function to parse json and prepare read to use Apod object
    func parse(completionHandler completion: @escaping (Apod?, SpaceCampError?) -> Void) {
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
    
}



