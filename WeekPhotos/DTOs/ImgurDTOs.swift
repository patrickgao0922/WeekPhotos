//
//  ImgurDTOs.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 18/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation

struct GalaryResponse:Codable {
    var data:[Galary]?
    var status:Int?
    var success:Bool?
}

struct Galary:Codable{
    var id:String?
    var cover: String?
    var coverWidth: Int?
    var coverHeight: Int?
    var images:[Image]?
    var topicId: Int?
    var points:Int?
    var score:Int?
    var link:String?
    
    enum CodingKeys:String, CodingKey {
        case topicId = "topic_id"
        case coverWidth = "cover_width"
        case coverHeight = "cover_height"
        
    }
}

struct Image:Codable {
    var id: String?
    var title: String?
    var description: String?
    var date: Date?
    var type: String?
    var width: Int?
    var height: Int?
    var size: Int?
    var link: String?
    
    enum CodingKeys:String, CodingKey {
        case date = "datetime"
    }
}
