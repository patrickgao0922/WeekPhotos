//
//  ImgurRouter.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 17/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import Moya



enum ImgurRouter:TargetType {
    
    enum Sort:String {
        case time
        case viral
        case top
    }
    
    enum Window:String {
        case day
        case week
        case month
        case year
        case all
    }
    
    case galary(sort:Sort?, window:Window?, page:Int?, q:String)
    
    var baseURL: URL {
        return URL(string: "https://api.imgur.com/3")!
    }
    
    var path: String {
        switch self {
        case .galary(let sort, window: let window, page: let page, _):
            var pathString = "/gallery/search"
            
            if let sort = sort {
                pathString += "/\(sort.rawValue)"
            } else {
                pathString += "/\(Sort.top.rawValue)"
            }
            
            if (sort == nil || sort == .top), let window = window {
                pathString += "/\(window.rawValue)"
            } else {
                pathString += "/\(Window.all.rawValue)"
            }
            
            if let page = page {
                pathString += "/\(page)"
            }
            return pathString
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .galary:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .galary(_,_,_,let q):
            return .requestParameters(parameters:["q_any":q],encoding:URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .galary(_,_,_,_):
            return "{\"data\":{\"id\": 100, \"images\": []\"},\"success\":true,\"status\":200}".data(using: .utf8)!
        }
    }
    var headers: [String : String]? {
        guard let id = Configuration.imgurClientId else {
            return nil
        }
        return ["Authorization": "Client-ID \(id)"]
    }
}
