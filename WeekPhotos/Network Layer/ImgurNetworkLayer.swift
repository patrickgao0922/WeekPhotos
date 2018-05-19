//
//  NetworkLayer.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 18/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//#imageLiteral(resourceName: "Technical Exercise Instructions - Mobile Dev.pdf")

import Foundation
import RxSwift
import Moya

protocol ImgurNetworkLayer {
    func searchGalaries(sort:ImgurRouter.Sort?, window:ImgurRouter.Window? ,page:Int?, query:String) -> Single<Response>
    func obtainImage(by imageHash:String) ->Single<Response>
}

class ImgurNetworkLayerImplementation:ImgurNetworkLayer {
    fileprivate var provider:MoyaProvider<ImgurRouter>
    init() {
        self.provider = MoyaProvider<ImgurRouter>()
    }
    
    func searchGalaries(sort:ImgurRouter.Sort? = .top, window:ImgurRouter.Window? = .all,page:Int? = nil, query:String) -> Single<Response> {
        return provider.rx.request(ImgurRouter.galary(sort: sort, window: window, page: page, q: query))
    }
    
    func obtainImage(by imageHash:String) ->Single<Response> {
        return provider.rx.request(ImgurRouter.image(imageHash: imageHash))
    }
}
