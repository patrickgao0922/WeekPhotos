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
        
        var container:Container!
        var dependencyRegistry:DependencyRegistry!
        var translationLayer:ImgurTranslationLayer!
        
        beforeSuite {
            container = Container()
            dependencyRegistry = DependencyRegistry(with: container)
            translationLayer = dependencyRegistry.container.resolve(ImgurTranslationLayer.self)!
        }
        it("translate data into galary dto") {
            
            let data:Data! = ImgurRouter.galary(sort: nil, window: nil, page: nil, q: "").sampleData
            let galaryResponse = translationLayer.translateDataIntoGalaryResponseDTO(data: data)
            expect(galaryResponse).toNot(beNil())
            expect(galaryResponse?.status).notTo(beNil())
            expect(galaryResponse!.status).to(equal(200))
            expect(galaryResponse!.data![0].images![0].id).notTo(beNil())
        }
        
        it("translate data into image dto") {
            let data:Data = ImgurRouter.image(imageHash: "").sampleData
            let imageResponse = translationLayer.translateDataIntoImageResponseDTO(data: data)
            
            expect(imageResponse).toNot(beNil())
            expect(imageResponse!.status).to(equal(200))
            expect(imageResponse!.data).toNot(beNil())
            expect(imageResponse!.data!.id!).to(equal("MepwY08"))
            expect(imageResponse!.data!.date).notTo(beNil())
            expect(imageResponse!.data!.date!.timeIntervalSince1970).to(equal(1526055953))
        }
    }
}
