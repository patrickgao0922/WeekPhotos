//
//  ImgurRouterTests.swift
//  WeekPhotosTests
//
//  Created by Patrick Gao on 18/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import WeekPhotos

class ImgurRouterTests:QuickSpec {
    override func spec() {
        var route:ImgurRouter!
        beforeEach {
            route = ImgurRouter.galary(sort: .top, window: .week, page: 1, q: "test")
        }
        
        it("uses correct baseURl:") {
            expect(route.baseURL).to(equal(URL(string: "https://api.imgur.com/3")))
        }
        
        it("uses correct path") {
            expect(route.path).to(equal("/gallery/search/top/week/1"))
        }
        
        it("uses correct parameters") {
            if case let .requestParameters(parameters: parameters, encoding: _) = route.task {
                let query = parameters["q_any"] as? String
                expect(query).toNot(beNil())
                expect(query!).to(equal("test"))
            }
        }
        
        it("contains Authorization") {
            let authentication = route.headers?["Authorization"]
            
            expect(authentication).notTo(beNil())
        }
    }
}
