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
    var title:String?
    var date:Date?
    var images:[Image]?
    var topicId: Int?
    var points:Int?
    var score:Int?
    
//    Properties for entity with single media
    var type: String?
    var width: Int?
    var height: Int?
    var link:String?
    
    enum CodingKeys:String, CodingKey {
        case id
        case title
        case images
        case points
        case score
        case topicId = "topic_id"
        case date = "datetime"
        
        case type
        case width
        case height
        case link

    }
}

struct ImageResponse:Codable {
    var data:Image?
    var status:Int?
    var success:Bool?
}

struct Image:Codable {
    var id: String?
    var date: Date?
    var type: String?
    var width: Int?
    var height: Int?
    var size: Int?
    var link: String?
    
    enum CodingKeys:String, CodingKey {
        case id
        case type
        case width
        case height
        case size
        case link
        case date = "datetime"
    }
}
