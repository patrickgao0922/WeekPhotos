//
//  ImgurNetworkLayerTests.swift
//  WeekPhotosTests
//
//  Created by Patrick Gao on 18/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Swinject
@testable import WeekPhotos

class ImgurNetworkLayerTests:QuickSpec {
    override func spec() {
        var container:Container!
        var dependencyRegistry:DependencyRegistry!
        var networkLayer:ImgurNetworkLayer!
        
        beforeSuite {
            container = Container()
            dependencyRegistry = DependencyRegistry(with: container)
            networkLayer = dependencyRegistry.container.resolve(ImgurNetworkLayer.self)
            
        }
    }
}
