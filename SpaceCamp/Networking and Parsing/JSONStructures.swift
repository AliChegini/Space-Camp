//
//  Structures.swift
//  SpaceCamp
//
//  Created by Ehsan on 08/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import Foundation

// struct to hold an apod object
struct Apod: Decodable {
    let title: String?
    let url: String?
    let hdurl: String?
    let explanation: String?
    let media_type: String?
}


// ---- Structs for MarsRover Objects

struct Camera: Decodable {
    let name: String?
    let full_name: String?
}

// struct to hold an MarsRover photo Object
struct MarsRoverPhoto: Decodable {
    let camera: Camera?
    let img_src: String?
    let earth_date: String?
}


struct MarsRoverPhotos: Decodable {
    let photos: [MarsRoverPhoto]
}



// ---- Structs for Mission Manifests

// struct to hold a manifest object
struct Manifest: Decodable {
    let name: String?
    let landing_date: String?
    let launch_date: String?
    let status: String?
    let max_date: String?
    let total_photos: Int?
}

struct RoverManifest: Decodable {
    let photo_manifest: Manifest
}


