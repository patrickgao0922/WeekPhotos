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
        guard let imgur = infoForKey("imgur") as? Dictionary<String,String> else {
            return nil
        }
        return imgur["Secret"]
    }
    
    fileprivate static func infoForKey(_ key: String) -> Any? {
        return (Bundle.main.infoDictionary?[key])
    }
}
