//
//  GalaryTableViewModelImplementationTests.swift
//  WeekPhotosTests
//
//  Created by Patrick Gao on 20/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Swinject
@testable import WeekPhotos

class GalaryTableViewModelImplementationTests:QuickSpec {
    override func spec() {
        
        var container:Container!
        var dependencyRegistry:DependencyRegistry!
        var viewModel:GalaryTableViewModel?
        
        beforeSuite {
            container = Container()
            dependencyRegistry = DependencyRegistry(with: container)
            
        }
        
        it("create view model") {
           viewModel = dependencyRegistry.container.resolve(GalaryTableViewModel.self)
            expect(viewModel).notTo(beNil())
//            expect(viewModel.)
        }
    }
}
