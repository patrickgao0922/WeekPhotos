//
//  ConfigurationTests.swift
//  WeekPhotosTests
//
//  Created by Patrick Gao on 17/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Swinject
@testable import WeekPhotos

class ConfigurationTests:QuickSpec {
    override func spec() {
        
        it("Test Imgur ID:") {
            expect(Configuration.imgurClientId).notTo(beNil())
        }
        
        it("Test Imgur Secret") {
            expect(Configuration.imgurClientSecret).notTo(beNil())
        }
    }
}
