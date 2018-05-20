//
//  GalaryTableViewCellViewModel.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 19/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation

protocol GalaryTableViewCellViewModel{
    var title:String? {get}
    var dateString:String? {get}
    var additionalImageCount:Int {get}
}

class GalaryTableViewCellViewModelImplementation:GalaryTableViewCellViewModel{
    
    fileprivate var galary:Galary
    var title:String?
    var dateString:String?
    var additionalImageCount:Int
    fileprivate weak var dateFormatter:DateFormatter!
    
    init(with galary:Galary,dateFormatter:DateFormatter) {
        self.galary = galary
        self.dateFormatter = dateFormatter
        title = galary.title
        
        if let date = galary.date {
            dateString = dateFormatter.string(from: date)
        }
        
        if let imageCount = galary.images?.count {
            additionalImageCount = imageCount-1>0 ? imageCount-1 : 0
        }
        else {
            additionalImageCount = 0
            
        }
    }
}

extension GalaryTableViewCellViewModelImplementation {
    func setupObservables() {
        
    }
}
