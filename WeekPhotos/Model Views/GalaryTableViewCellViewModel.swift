//
//  GalaryTableViewCellViewModel.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 19/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import UIKit

protocol GalaryTableViewCellViewModel{
    var imageSize:CGSize {get}
    var title:String? {get}
    var dateString:String? {get}
    var additionalImageCount:Int {get}
}

class GalaryTableViewCellViewModelImplementation:GalaryTableViewCellViewModel{
    
    fileprivate var galary:Galary
    var title:String?
    var dateString:String?
    var additionalImageCount:Int
    var imageSize:CGSize
    
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
        
        self.imageSize = CGSize(width: 400, height: 300)
        if let width = galary.images?[0].width, let height = galary.images?[0].height {
            self.imageSize = CGSize(width: width, height: height)
        }
        
    }
}

extension GalaryTableViewCellViewModelImplementation {
    func setupObservables() {
        
    }
}
