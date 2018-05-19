//
//  ImgurgalaryrTests.swift
//  WeekPhotosTests
//
//  Created by Patrick Gao on 18/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import WeekPhotos

class ImgurgalaryrTests:QuickSpec {
    override func spec() {
        var galary:ImgurRouter!
        var image:ImgurRouter!
        beforeEach {
            galary = ImgurRouter.galary(sort: .top, window: .week, page: 1, q: "test")
            
            image = .image(imageHash: "MepwY08")
        }
        
        describe("galary route") {
            it("uses correct baseURl:") {
                expect(galary.baseURL).to(equal(URL(string: "https://api.imgur.com/3")))
            }
            
            it("use correct method") {
                expect(galary.method.rawValue).to(equal("GET"))
            }
            
            it("uses correct path") {
                expect(galary.path).to(equal("/gallery/search/top/week/1"))
            }
            
            it("uses correct parameters") {
                if case let .requestParameters(parameters: parameters, encoding: _) = galary.task {
                    let query = parameters["q_any"] as? String
                    expect(query).toNot(beNil())
                    expect(query!).to(equal("test"))
                }
            }
            
            it("contains Authorization") {
                let authentication = galary.headers?["Authorization"]
                
                expect(authentication).notTo(beNil())
            }
        }
        describe("image route") {
            it("uses correct baseURl:") {
                expect(image.baseURL).to(equal(URL(string: "https://api.imgur.com/3")))
            }
            
            it("uses correct path") {
                expect(image.path).to(equal("/image/MepwY08"))
            }
            
            it("use correct method") {
                expect(image.method.rawValue).to(equal("GET"))
            }
            
            it("contains Authorization") {
                let authentication = image.headers?["Authorization"]
                
                expect(authentication).notTo(beNil())
            }
        }
        
    }
}
