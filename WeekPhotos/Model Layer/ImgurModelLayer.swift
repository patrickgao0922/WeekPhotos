//
//  ModelLayer.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 18/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import RxSwift

protocol ImgurModelLayer {
    func searchTopGalaries(query:String) -> Single<[Image]>
}

class ImgurModelLayerImplementation:ImgurModelLayer {
    fileprivate var networkLayer:ImgurNetworkLayer
    fileprivate var translationLayer:ImgurTranslationLayer
    init(with networkLayer:ImgurNetworkLayer, translationLayer:ImgurTranslationLayer) {
        self.networkLayer = networkLayer
        self.translationLayer = translationLayer
    }
    
    /// Obtain all top images of the week based on the query
    ///
    /// - Parameter query: query string
    /// - Returns: Single Trait with image array result
    func searchTopGalaries(query:String) -> Single<[Image]>{
        return networkLayer.searchGalaries(sort: .top, window: .week, page: nil, query: query)
            .map { (response) -> [Galary] in
                let data = response.data
                guard let galaries =  self.translationLayer.translateDataIntoGalaryResponseDTO(data: data)?.data else {
                    return []
                }
                return galaries
        }
            .map { (galaries) -> [Image] in
                var images:[Image] = []
                for galary in galaries where galary.images != nil && galary.images!.count != 0 {
                    images.append(contentsOf: galary.images!)
                }
                return images
        }
        
    }
}
