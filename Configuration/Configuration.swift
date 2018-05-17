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
}

class ConfigurationImplementation:Configuration {
    
    var imgurClientId:String? {
        guard let google = infoForKey("Google") as? Dictionary<String,String> else {
            return nil
        }
        return google["API Key"]
    }
    
    fileprivate func infoForKey(_ key: String) -> Any? {
        return (Bundle.main.infoDictionary?[key])
    }
}
