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
            return """
                {
                \"data\": [
                {
                \"id\": \"cMeqGsr\",
                \"title\": \"Fueled by daily whiskey and cigars, my cousin Richard Overton is the oldest man in the USA and today is his 112th Birthday!\",
                \"description\": null,
                \"datetime\": 1526056301,
                \"cover\": \"MepwY08\",
                \"cover_width\": 2560,
                \"cover_height\": 1280,
                \"account_url\": \"greenninjatx\",
                \"account_id\": 6893723,
                \"privacy\": \"public\",
                \"layout\": \"blog\",
                \"views\": 208300,
                \"link\": \"https://imgur.com/a/cMeqGsr\",
                \"ups\": 6547,
                \"downs\": 89,
                \"points\": 6458,
                \"score\": 6562,
                \"is_album\": true,
                \"vote\": null,
                \"favorite\": false,
                \"nsfw\": false,
                \"section\": \"\",
                \"comment_count\": 309,
                \"favorite_count\": 488,
                \"topic\": \"No Topic\",
                \"topic_id\": 29,
                \"images_count\": 1,
                \"in_gallery\": true,
                \"is_ad\": false,
                \"tags\": [
                {
                \"name\": \"pimpin_aint_easy\",
                \"display_name\": \"pimpinainteasy\",
                \"followers\": 11,
                \"total_items\": 39,
                \"following\": false,
                \"background_hash\": \"gmFssAG\",
                \"thumbnail_hash\": null,
                \"accent\": \"51535A\",
                \"background_is_animated\": false,
                \"thumbnail_is_animated\": false,
                \"is_promoted\": false,
                \"description\": \"\",
                \"logo_hash\": null,
                \"logo_destination_url\": null,
                \"description_annotations\": {}
                }]
                """
                .data(using: .utf8)!
        }
    }
    var headers: [String : String]? {
        guard let id = Configuration.imgurClientId else {
            return nil
        }
        return ["Authorization": "Client-ID \(id)"]
    }
}
