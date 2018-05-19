//
//  GalaryTableViewModel.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 19/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
protocol GalaryTableViewModel {
    
}

class GalaryTableViewModelImplementation:GalaryTableViewModel {
    
    fileprivate var cellViewModels:[GalaryTableViewCellViewModel]
    
    init() {
        cellViewModels = []
    }
}
