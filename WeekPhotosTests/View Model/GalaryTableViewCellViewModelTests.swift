//
//  GalaryTableViewCellViewModelTests.swift
//  WeekPhotosTests
//
//  Created by Patrick Gao on 20/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import WeekPhotos

class GalaryTableViewCellViewModelImplementationTests:QuickSpec {
    override func spec() {
        var cellViewModel:GalaryTableViewCellViewModel!
        var galary:Galary!
        beforeSuite {
            galary = Galary(id: "test", title: "test", date: Date(), images: [], topicId: 83, points: 93, score: 39)
            cellViewModel = GalaryTableViewCellViewModelImplementation(with: galary)
        }
    }
}
