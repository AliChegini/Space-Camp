//
//  SpaceCampTests.swift
//  SpaceCampTests
//
//  Created by Ehsan on 23/01/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import XCTest

@testable import SpaceCamp

class SpaceCampTests: XCTestCase {

    let client = NasaAPIClient()
    let parser = JSONParser()
    let separator = PhotoSeparator()
    
    
    // success test case for getData from APIClient class
    func testGetData() {
        
        let expectation = self.expectation(description: "GetData")
        
        var dataValue: Data?
        var errorValue: SpaceCampError?
        
        let url = "https://apod.nasa.gov/apod/image/1901/OrionAlps_Vesely_960.jpg"
        
        
        client.getData(from: url) { data, error in
            if let error = error {
                errorValue = error
            }
            
            if let data = data {
                dataValue = data
            }
            
            // Fullfil the expectation to let the test runner
            // know that it's OK to proceed
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fullfilled, or time out
        // after x seconds. Test runner will pause for asynch call to complete
        waitForExpectations(timeout: 10.0, handler: nil)
        
        // data should not be nil
        XCTAssertNotNil(dataValue)
        // error should be nil
        XCTAssertNil(errorValue)
    }
    
    
    
    // fail test case for getData from APIClient class
    // missing url should return nil
    func testGetDataMissingURL() {
        
        let expectation = self.expectation(description: "GetDataMissingURL")
        
        var dataValue: Data?
        var errorValue: SpaceCampError?
        
        // empty url should return nil
        let url = ""
        
        
        client.getData(from: url) { data, error in
            if let error = error {
                errorValue = error
            }
            
            if let data = data {
                dataValue = data
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        // missing url should return error, data should be nil
        XCTAssertNil(dataValue)
        XCTAssertNotNil(errorValue)
    }
    
    
    
    // success test case for parseApod from JSONParser class
    func testParseApod() {
        // create expectation
        let expectation = self.expectation(description: "Apod")
        
        var apodValue: Apod?
        var errorValue: SpaceCampError?
        
        parser.parseApod { apod, error in
            if let error = error {
                errorValue = error
            }
            
            if let apod = apod {
                apodValue = apod
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        // apod should not be nil
        XCTAssertNotNil(apodValue)
        // error should be nil since apod is not nil
        XCTAssertNil(errorValue)
    }
    
    
    
    // success test case for parseManifest from JSONParser class
    // rover : Curiosity
    func testParseManifestCuriosity() {
        
        let expectation = self.expectation(description: "ManifestCuriosity")
        
        var manifestValue: RoverManifest?
        var errorValue: SpaceCampError?
        
        let roverName = "curiosity"
        
        parser.parseManifest(for: roverName) { manifest, error in
            if let error = error {
                errorValue = error
            }
            
            if let manifest = manifest {
                manifestValue = manifest
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        XCTAssertNotNil(manifestValue)
        XCTAssertNil(errorValue)
        
        // rover name matches the requested rover
        XCTAssertEqual(manifestValue?.photo_manifest.name, roverName.capitalized)
    }
    
    
    // success test case for parseManifest from JSONParser class
    // rover : Opportunity
    func testParseManifestOpportunity() {
        
        let expectation = self.expectation(description: "ManifestOpportunity")
        
        var manifestValue: RoverManifest?
        var errorValue: SpaceCampError?
        
        let roverName = "opportunity"
        
        parser.parseManifest(for: roverName) { manifest, error in
            if let error = error {
                errorValue = error
            }
            
            if let manifest = manifest {
                manifestValue = manifest
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        
        XCTAssertNotNil(manifestValue)
        XCTAssertNil(errorValue)
        // rover name matches the requested rover
        XCTAssertEqual(manifestValue?.photo_manifest.name, roverName.capitalized)
        
    }
    
    
    // success test case for parseManifest from JSONParser class
    // rover : Spirit
    func testParseManifestSpirit() {
        
        let expectation = self.expectation(description: "ManifestSpirit")
        
        var manifestValue: RoverManifest?
        var errorValue: SpaceCampError?
        
        let roverName = "spirit"
        
        parser.parseManifest(for: roverName) { manifest, error in
            if let error = error {
                errorValue = error
            }
            
            if let manifest = manifest {
                manifestValue = manifest
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        
        XCTAssertNotNil(manifestValue)
        XCTAssertNil(errorValue)
        // rover name matches the requested rover
        XCTAssertEqual(manifestValue?.photo_manifest.name, roverName.capitalized)
        
    }
    
    
    
    // fail test case for parseManifest from JSONParser class
    // missing or misspeling rover name should produce error
    func testParseManifestFail() {
        
        let expectation = self.expectation(description: "ManifestMissingRoverName")
        
        var manifestValue: RoverManifest?
        var errorValue: SpaceCampError?
        
        // misspelling rover name
        let roverName = ""
        
        parser.parseManifest(for: roverName) { manifest, error in
            if let error = error {
                errorValue = error
            }
            
            if let manifest = manifest {
                manifestValue = manifest
            }
            
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        // should get back error , data should be nil
        XCTAssertNil(manifestValue)
        XCTAssertNotNil(errorValue)
    }
    
    
    // success test case for parsePhotos from JSONParser class
    // rover : Curiosity
    func testParsePhotosCuriosity() {
        
        let expectation = self.expectation(description: "ParsePhotosCuriosity")
        
        var photosValue: MarsRoverPhotos?
        var errorValue: SpaceCampError?
        
        let roverName = "curiosity"
        let date = "2017-01-01"
        
        parser.parsePhotos(roverName: roverName, date: date) { photos, error in
            if let error = error {
                errorValue = error
            }
            
            if let photos = photos {
                photosValue = photos
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        // should return data, error should be nil
        XCTAssertNotNil(photosValue)
        XCTAssertNil(errorValue)
    }
    
    
    // success test case for parsePhotos from JSONParser class
    // rover : Opportunity
    func testParsePhotosOpportunity() {
        
        let expectation = self.expectation(description: "ParsePhotosOpportunity")
        
        var photosValue: MarsRoverPhotos?
        var errorValue: SpaceCampError?
        
        let roverName = "opportunity"
        let date = "2017-01-01"
        
        parser.parsePhotos(roverName: roverName, date: date) { photos, error in
            if let error = error {
                errorValue = error
            }
            
            if let photos = photos {
                photosValue = photos
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        // should return data, error should be nil
        XCTAssertNotNil(photosValue)
        XCTAssertNil(errorValue)
    }
    
    
    // success test case for parsePhotos from JSONParser class
    // rover : Spirit
    func testParsePhotosSpirit() {
        
        let expectation = self.expectation(description: "ParsePhotosSpirit")
        
        var photosValue: MarsRoverPhotos?
        var errorValue: SpaceCampError?
        
        let roverName = "spirit"
        let date = "2017-01-01"
        
        parser.parsePhotos(roverName: roverName, date: date) { photos, error in
            if let error = error {
                errorValue = error
            }
            
            if let photos = photos {
                photosValue = photos
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        // should return data, error should be nil
        XCTAssertNotNil(photosValue)
        XCTAssertNil(errorValue)
    }
    
    
    // fail test case for parsePhotos from JSONParser class
    // invalid rover name and invalid date
    // should return error, data should be nil
    func testParsePhotosFail() {
        
        let expectation = self.expectation(description: "ParsePhotosFail")
        
        var photosValue: MarsRoverPhotos?
        var errorValue: SpaceCampError?
        
        let roverName = "spir"
        let date = "2017-01-"
        
        parser.parsePhotos(roverName: roverName, date: date) { photos, error in
            if let error = error {
                errorValue = error
            }
            
            if let photos = photos {
                photosValue = photos
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        // should return error, data should be nil
        XCTAssertNil(photosValue)
        XCTAssertNotNil(errorValue)
    }
    
    

    
    // success test case for prepareReadyPhotoArray from PhotoSeparator class
    // rover : Curiosity
    func testPrepareReadyPhotoArrayCuriosity() {
        
        let expectation = self.expectation(description: "ReadyPhotoArrayCuriosity")
        
        var readyPhotoArrayValue: [ReadyPhotoObject]?
        var errorValue: SpaceCampError?
        
        let roverName = "curiosity"
        let date = "2017-01-01"
        
        separator.prepareReadyPhotoArray(roverName: roverName, date: date) { photoArray, error in
            if let error = error {
                errorValue = error
            }
            
            if let photoArray = photoArray {
                readyPhotoArrayValue = photoArray
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        XCTAssertNotNil(readyPhotoArrayValue)
        XCTAssertNil(errorValue)
        
    }
    
    
    // success test case for prepareReadyPhotoArray from PhotoSeparator class
    // rover : Opportunity
    func testPrepareReadyPhotoArrayOpportunity() {
        
        let expectation = self.expectation(description: "ReadyPhotoArrayOpportunity")
        
        var readyPhotoArrayValue: [ReadyPhotoObject]?
        var errorValue: SpaceCampError?
        
        let roverName = "opportunity"
        let date = "2017-01-01"
        
        separator.prepareReadyPhotoArray(roverName: roverName, date: date) { photoArray, error in
            if let error = error {
                errorValue = error
            }
            
            if let photoArray = photoArray {
                readyPhotoArrayValue = photoArray
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        XCTAssertNotNil(readyPhotoArrayValue)
        XCTAssertNil(errorValue)
        
    }
    
    
    
    // success test case for prepareReadyPhotoArray from PhotoSeparator class
    // rover : Spirit
    func testPrepareReadyPhotoArraySpirit() {
        
        let expectation = self.expectation(description: "ReadyPhotoArraySpirit")
        
        var readyPhotoArrayValue: [ReadyPhotoObject]?
        var errorValue: SpaceCampError?
        
        let roverName = "spirit"
        let date = "2017-01-01"
        
        separator.prepareReadyPhotoArray(roverName: roverName, date: date) { photoArray, error in
            if let error = error {
                errorValue = error
            }
            
            if let photoArray = photoArray {
                readyPhotoArrayValue = photoArray
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        XCTAssertNotNil(readyPhotoArrayValue)
        XCTAssertNil(errorValue)
        
    }
    
    
    
    // fail test case for prepareReadyPhotoArray from PhotoSeparator class
    // misspelling the rover name
    func testPrepareReadyPhotoArrayFail() {

        let expectation = self.expectation(description: "ReadyPhotoArrayFail")

        var readyPhotoArrayValue: [ReadyPhotoObject]?
        var errorValue: SpaceCampError?

        // misspelling rover name and invalid date should return error
        let roverName = "curiosit"
        let date = "2019-01-"

        separator.prepareReadyPhotoArray(roverName: roverName, date: date) { photoArray, error in
            if let error = error {
                errorValue = error
            }

            if let photoArray = photoArray {
                readyPhotoArrayValue = photoArray
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 10.0, handler: nil)

        // should get back error
        XCTAssertNil(readyPhotoArrayValue)
        XCTAssertNotNil(errorValue)

    }
    
    

}
