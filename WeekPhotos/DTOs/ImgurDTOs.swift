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
    var date:Date?
    var images:[Image]?
    var topicId: Int?
    var points:Int?
    var score:Int?
    var link:String?
    
    enum CodingKeys:String, CodingKey {
        case id
        case cover
        case images
        case points
        case score
        case link
        case topicId = "topic_id"
        case coverWidth = "cover_width"
        case coverHeight = "cover_height"
        case date = "datetime"

    }
}

struct ImageResponse:Codable {
    var data:Image?
    var status:Int?
    var success:Bool?
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
        case id
        case title
        case description
        case type
        case width
        case height
        case size
        case link
        case date = "datetime"
    }
}
