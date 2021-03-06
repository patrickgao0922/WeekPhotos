//
//  ImgurModelLayerTests.swift
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

class ImgurModelLayerTests:QuickSpec {
    override func spec() {
        var container:Container!
        var dependencyRegistry:DependencyRegistry!
        var modelLayer:ImgurModelLayer!
        beforeSuite {
            container = Container()
            dependencyRegistry = DependencyRegistry(with: container)
            modelLayer = dependencyRegistry.container.resolve(ImgurModelLayer.self)
        }
        
        it("fetch galaries") {
            let result = modelLayer.searchTopGalaries(query: "usa").toBlocking().materialize()
            
            switch result {
            case .completed(let elements):
                expect(elements[0].count).notTo(equal(0))
            case .failed(_, let error):
                fail(error.localizedDescription)
            }
        }
        
        it("fetch single image") {
            let result = modelLayer.obtainImage(by: "MepwY08").toBlocking().materialize()
            
            switch result {
            case .completed(let elements):
                expect(elements[0]).notTo(beNil())
                expect(elements[0]!.id).notTo(beNil())
                expect(elements[0]!.id!).to(equal("MepwY08"))
            case .failed(_, let error):
                fail(error.localizedDescription)
            }
        }
        
    }
}
