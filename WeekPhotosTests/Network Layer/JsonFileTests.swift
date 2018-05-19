//
//  JsonFileTests.swift
//  WeekPhotosTests
//
//  Created by Patrick Gao on 19/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import WeekPhotos

class JsonFileTests:QuickSpec {
    override func spec () {
        it("Obtain galary dump data") {
            expect(JsonFile.galary.jsonFileFile).notTo(beNil())
        }
        
        it("Obtain image dump data") {
            expect(JsonFile.image.jsonFileFile).notTo(beNil())
        }
    }
}
