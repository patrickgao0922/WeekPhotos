//
//  JsonFileLoader.swift
//  WeekPhotos
//
//  Created by Patrick Gao on 19/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation


enum JsonFile:String {
    case galary = "galary_query_response"
    case image = "image_response"
    
    var jsonFileFile: Data? {
        guard let path = Bundle.main.path(forResource: rawValue, ofType: "json") else {
            return nil
        }
        do {
            return try Data(contentsOf: URL(fileURLWithPath: path), options: Data.ReadingOptions.alwaysMapped)
        }
        catch {
            return nil
        }
    }
}
