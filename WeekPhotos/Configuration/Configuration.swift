//
//  Configuration.swift
//  WeekPhotosTests
//
//  Created by Patrick Gao on 17/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
class Configuration {
    
    static var imgurClientId:String? {
        guard let imgur = infoForKey("Imgur") as? Dictionary<String,String> else {
            return nil
        }
        return imgur["ID"]
    }
    
    static var imgurClientSecret:String? {
        guard let imgur = infoForKey("Imgur") as? Dictionary<String,String> else {
            return nil
        }
        return imgur["Secret"]
    }
    
    static var loadTestJsonFile:Data? {
        guard let path = Bundle.main.path(forResource: "dump_test_response", ofType: "json") else {
            return nil
        }
        do {
            return try Data(contentsOf: URL(fileURLWithPath: path), options: Data.ReadingOptions.alwaysMapped)
        }
        catch {
            return nil
        }
    }
    
    fileprivate static func infoForKey(_ key: String) -> Any? {
        return (Bundle.main.infoDictionary?[key])
    }
}
