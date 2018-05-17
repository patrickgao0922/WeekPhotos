//
//  Configuration.swift
//  WeekPhotosTests
//
//  Created by Patrick Gao on 17/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
protocol Configuration {
    var imgurClientId:String? {get}
    var imgurClientSecret:String? {get}
}

class ConfigurationImplementation:Configuration {
    
    var imgurClientId:String? {
        guard let imgur = infoForKey("Imgur") as? Dictionary<String,String> else {
            return nil
        }
        return imgur["ID"]
    }
    
    var imgurClientSecret:String? {
        guard let imgur = infoForKey("Imgur") as? Dictionary<String,String> else {
            return nil
        }
        return imgur["Secret"]
    }
    
    fileprivate func infoForKey(_ key: String) -> Any? {
        return (Bundle.main.infoDictionary?[key])
    }
}
