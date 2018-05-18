//
//  ImgurNetworkLayerTests.swift
//  WeekPhotosTests
//
//  Created by Patrick Gao on 18/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import Quick
import RxBlocking
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
        
        it("Get galary response successfully") {
            let result = networkLayer.searchGalaries(sort: .top, window: .week, page: nil, query: "usa").toBlocking().materialize()
            
            switch result {
            case .completed(let responses):
                expect(responses[0].statusCode).to(equal(200))
            case .failed(_, let error):
                fail(error.localizedDescription)
            }
        }
    }
}
