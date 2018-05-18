//
//  ModelLayer.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 18/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation

protocol ImgurModelLayer {
    
}

class ImgurModelLayerImplementation:ImgurModelLayer {
    var networkLayer:ImgurNetworkLayer
    init(with networkLayer:ImgurNetworkLayer) {
        self.networkLayer = networkLayer
    }
    
    func searchTopGalaries(query:String) {
        networkLayer.searchGalaries(sort: .top, window: .week, page: nil, query: query)
//            .map { (response) -> GalaryResponse in
//                let jsonDecoder = response.data
//                let galaryGalary = GalaryResponse(from: jsonData)
//        }
    }
}
