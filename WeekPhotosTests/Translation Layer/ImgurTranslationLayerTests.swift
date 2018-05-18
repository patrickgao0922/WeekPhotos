//
//  ImgurTranslationLayerTests.swift
//  WeekPhotosTests
//
//  Created by Patrick Gao on 18/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import Quick
import Swinject
import Nimble
@testable import WeekPhotos

class ImgurTranslationLayerTests:QuickSpec {
    override func spec() {
        
        var data:Data!
        var container:Container!
        var dependencyRegistry:DependencyRegistry!
        var translationLayer:ImgurTranslationLayer!
        
        beforeSuite {
            container = Container()
            dependencyRegistry = DependencyRegistry(with: container)
            translationLayer = dependencyRegistry.container.resolve(ImgurTranslationLayer.self)!
            data = ImgurRouter.galary(sort: nil, window: nil, page: nil, q: "").sampleData
        }
        it("translate data into galary dto") {
            let galaryResponse = translationLayer.translateDataIntoGalaryResponseDTO(data: data)
            expect(galaryResponse).toNot(beNil())
            expect(galaryResponse?.status).notTo(beNil())
            expect(galaryResponse!.status).to(equal(200))
        }
    }
}
