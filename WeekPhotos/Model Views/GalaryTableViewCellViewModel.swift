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
    var date:Date? {get}
    var additionalImageCount:Int {get}
}

class GalaryTableViewCellViewModelImplementation:GalaryTableViewCellViewModel{
    
    fileprivate var galary:Galary
    var title:String?
    var date:Date?
    var additionalImageCount:Int
    
    init(with galary:Galary) {
        self.galary = galary
        
        title = galary.title
        date = galary.date
        
        if let imageCount = galary.images?.count {
            additionalImageCount = imageCount-1>0 ? imageCount-1 : 0
        }
        else {
            additionalImageCount = 0
            
        }
    }
}
