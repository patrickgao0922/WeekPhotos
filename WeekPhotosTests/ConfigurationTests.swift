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
        let container = Container()
        let dependencyRegistry = DependencyRegistry(with: container)
        let configuration = dependencyRegistry.container.resolve(Configuration.self)!
        
        it("Test Imgur ID:") {
            expect(configuration.imgurClientId).notTo(beNil())
        }
        
        it("Test Imgur Secret") {
            expect(configuration.imgurClientSecret).notTo(beNil())
        }
    }
}
