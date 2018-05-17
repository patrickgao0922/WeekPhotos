//
//  NetworkLayer.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 18/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol ImgurNetworkLayer {
    func searchTopGalaries(query:String) -> Single<Response>
}

class ImgurNetworkLayerImplementation:ImgurNetworkLayer {
    fileprivate var provider:MoyaProvider<ImgurRouter>
    init() {
        self.provider = MoyaProvider<ImgurRouter>()
    }
    
    func searchTopGalaries(query:String) -> Single<Response> {
        return provider.rx.request(ImgurRouter.galary(sort: .time, window: .week, page: 1, q: query))
    }
}
