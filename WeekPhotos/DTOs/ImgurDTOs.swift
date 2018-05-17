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
    var images:[Image]?
}

struct Image:Codable {
    var id: String?
    var title: String?
    var description: String?
    var datetime: Date?
    var type: String?
    var width: Int?
    var height: Int?
    var size: Int?
    var link: String?
}
