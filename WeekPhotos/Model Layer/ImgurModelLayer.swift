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
                for galary in galaries {
                    if let galaryImages = galary.images {
                        images.append(contentsOf: galaryImages)
                    }
                }
                return images
        }
        
    }
}
