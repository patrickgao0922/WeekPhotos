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
    case image(imageHash:String)
    
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
        case .image(let imageHash):
            return "/image/\(imageHash)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .galary:
            return .get
        case .image:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .galary(_,_,_,let q):
            return .requestParameters(parameters:["q_any":q],encoding:URLEncoding.queryString)
        case .image:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
        case .galary(_,_,_,_):
            return JsonFile.galary.jsonFileFile!
        case .image:
            return JsonFile.image.jsonFileFile!
        }
    }
    var headers: [String : String]? {
        guard let id = Configuration.imgurClientId else {
            return nil
        }
        return ["Authorization": "Client-ID \(id)"]
    }
}
